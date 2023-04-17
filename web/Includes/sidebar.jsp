<%-- 
    Document   : sidebar
    Created on : 01 4, 21, 11:12:17 AM
    Author     : IT-Programmer
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/Includes/DBConnection.jsp" %>
<!DOCTYPE html>
<html>
    <c:set var="Users" value="${USERID}1"/>
    <c:choose>
        <c:when test="${Users == '1'}">
            <script>
                alert("Please Login!");

                window.location.href = 'index.jsp';

            </script>
        </c:when>
        <c:otherwise>
            <!-- Sidebar -->
            <ul class="navbar-nav bg-gradient-info sidebar sidebar-dark accordion" id="accordionSidebar">
                <!-- Sidebar - Brand -->
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">
                    <div class="sidebar-brand-icon rotate-n-15">
                        <i class="fas fa-rocket"></i>
                    </div>
                    <div class="sidebar-brand-text mx-3">Merchant Onboarding <sup></sup></div>
                </a>

                <!-- Divider -->
                <hr class="sidebar-divider my-0">

                <c:choose>
                    <c:when test="${USERGROUP > 4}">

                    </c:when>
                    <c:otherwise>
                        <!-- Nav Item - Dashboard -->
                        <li class="nav-item active">
                            <a class="nav-link" href="dashboard.jsp">
                                <i class="fas fa-fw fa-tachometer-alt"></i>
                                <span>Dashboard</span></a>
                        </li>
                    </c:otherwise>


                </c:choose>
                <!--Get MainMenuGroup-->
                <sql:query dataSource = "${ALBMOSDB}" var = "resultMainMenuGroups">
                    EXEC GetSidebarMainMenuGroupAccess ${USERID}
                </sql:query>
                <c:forEach var = "rowMainMenuGroups" items = "${resultMainMenuGroups.rows}">
                    <c:set var="MainMenuGroupAccess" value="${rowMainMenuGroups.MainMenuGroupAccess}"/>
                    <!-- Divider -->
                    <hr class="sidebar-divider">
                    <!-- Heading -->
                    <div class="sidebar-heading">
                        ${MainMenuGroupAccess}
                    </div>

                    <!--GetMainMenus-->
                    <sql:query dataSource = "${ALBMOSDB}" var = "resultMainMenuSubMenuCount">
                        EXEC GetSidebarMainMenuSubMenuCount ${USERID},${MainMenuGroupAccess}
                    </sql:query>
                    <c:forEach var = "rowMainMenuSubMenuCount" items = "${resultMainMenuSubMenuCount.rows}">
                        <c:set var="SubMenuCount" value="${rowMainMenuSubMenuCount.SubMenuCount}"/>
                        <c:set var="MenuGroupCode" value="${rowMainMenuSubMenuCount.MenuGroupCode}"/>
                        <c:choose>
                            <c:when test="${SubMenuCount < 1}">
                                <!--GetMainMenuDetails-->
                                <sql:query dataSource = "${ALBMOSDB}" var = "resultMainMenuDetails">
                                    EXEC GetSidebarMainMenuAccess ${USERID},${MenuGroupCode}
                                </sql:query>
                                <c:forEach var = "rowMainMenuDetails" items = "${resultMainMenuDetails.rows}">
                                    <c:set var="MENUCODE" value="${rowMainMenuDetails.MENUCODE}"/>
                                    <c:set var="Description" value="${rowMainMenuDetails.Description}"/>
                                    <c:set var="MenuIcon" value="${rowMainMenuDetails.MenuIcon}"/>
                                    <c:set var="MenuPageURL" value="${rowMainMenuDetails.MenuPageURL}"/>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${MenuPageURL}">
                                            <i class="${MenuIcon}"></i>
                                            <span>${Description}</span></a>
                                    </li>
                                </c:forEach>

                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <!--GetMainMenuDetails-->
                                    <sql:query dataSource = "${ALBMOSDB}" var = "resultMainMenuDetails">
                                        EXEC GetSidebarMainMenuAccess ${USERID},${MenuGroupCode}
                                    </sql:query>
                                    <c:forEach var = "rowMainMenuDetails" items = "${resultMainMenuDetails.rows}">
                                        <c:set var="MENUCODE" value="${rowMainMenuDetails.MENUCODE}"/>
                                        <c:set var="Description" value="${rowMainMenuDetails.Description}"/>
                                        <c:set var="MenuIcon" value="${rowMainMenuDetails.MenuIcon}"/>
                                        <c:set var="MenuPageURL" value="${rowMainMenuDetails.MenuPageURL}"/>

                                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapse${MENUCODE}"
                                           aria-expanded="true" aria-controls="collapse${MENUCODE}">
                                            <i class="${MenuIcon}"></i>
                                            <span>${Description}</span>
                                        </a>
                                        <div id="collapse${MENUCODE}" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                                            <div class="bg-white py-2 collapse-inner rounded">

                                                <sql:query dataSource = "${ALBMOSDB}" var = "resultMainMenuDetails">
                                                    EXEC GetSidebarSubMainMenuAccess ${USERID},${MenuGroupCode}
                                                </sql:query>
                                                <c:forEach var = "rowMainMenuDetails" items = "${resultMainMenuDetails.rows}">
                                                    <c:set var="MENUCODE" value="${rowMainMenuDetails.MENUCODE}"/>
                                                    <c:set var="Description" value="${rowMainMenuDetails.Description}"/>
                                                    <c:set var="MenuIcon" value="${rowMainMenuDetails.MenuIcon}"/>
                                                    <c:set var="MenuPageURL" value="${rowMainMenuDetails.MenuPageURL}"/>

                                                    <a class="collapse-item" href="${MenuPageURL}">${Description}</a>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:forEach>
                <!-- Divider -->
                <hr class="sidebar-divider d-none d-md-block">

                <!-- Sidebar Toggler (Sidebar) -->
                <div class="text-center d-none d-md-inline">
                    <button class="rounded-circle border-0" id="sidebarToggle"></button>
                </div>
            </ul>
            <!-- End of Sidebar -->
        </c:otherwise>
    </c:choose>



</html>
