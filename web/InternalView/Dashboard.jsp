<!-- Topbar -->
<%@ include file="/Includes/topbar.jsp" %>
<!-- End of Topbar -->

<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
        <!--a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                class="fas fa-download fa-sm text-white-50"></i> Generate Report</a-->
    </div>

    <!-- Content Row -->
    <div class="row">

        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                Approved Merchants</div>
                            <sql:query dataSource = "${ALBMOSDB}" var = "resultTotalMerchantCount">
                                EXEC GetMerchantCountPerStatus 1
                            </sql:query>
                            <c:forEach var = "rowTotalMerchantCount" items = "${resultTotalMerchantCount.rows}">
                                <c:set var="count" value="${rowTotalMerchantCount.count}"/>
                            </c:forEach>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">${count}</div>

                        </div>
                        <div class="col-auto">
                            <i class="fas fa-check fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                Pending</div>
                            <sql:query dataSource = "${ALBMOSDB}" var = "resultTotalMerchantCount">
                                EXEC GetMerchantCountPerStatus '0'
                            </sql:query>
                            <c:forEach var = "rowTotalMerchantCount" items = "${resultTotalMerchantCount.rows}">
                                <c:set var="count" value="${rowTotalMerchantCount.count}"/>
                            </c:forEach>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">${count}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clock fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Disapproved
                            </div>
                            <div class="row no-gutters align-items-center">
                                <div class="col-auto">
                                    <sql:query dataSource = "${ALBMOSDB}" var = "resultTotalMerchantCount">
                                        EXEC GetMerchantCountPerStatus 2
                                    </sql:query>
                                    <c:forEach var = "rowTotalMerchantCount" items = "${resultTotalMerchantCount.rows}">
                                        <c:set var="count" value="${rowTotalMerchantCount.count}"/>
                                    </c:forEach>
                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${count}</div>
                                </div>
                               
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-exclamation-triangle fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pending Requests Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-danger shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                Rejected </div>
                              <sql:query dataSource = "${ALBMOSDB}" var = "resultTotalMerchantCount">
                                        EXEC GetMerchantCountPerStatus 3
                                    </sql:query>
                                    <c:forEach var = "rowTotalMerchantCount" items = "${resultTotalMerchantCount.rows}">
                                        <c:set var="count" value="${rowTotalMerchantCount.count}"/>
                                    </c:forEach>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">${count}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-trash fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Content Row -->

    <div class="row">

        <!-- Area Chart -->
        <div class="col-xl-8 col-lg-7">
            <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div
                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary">On-boarded Merchants Overview</h6>
                    <div class="dropdown no-arrow">
                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                             aria-labelledby="dropdownMenuLink">
                            <div class="dropdown-header">Dropdown Header:</div>
                            <a class="dropdown-item" href="#">Action</a>
                            <a class="dropdown-item" href="#">Another action</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                    </div>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                    <div class="chart-area">
                         <canvas id="myAreaChartInternal"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pie Chart -->
        <div class="col-xl-4 col-lg-5">
            <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div
                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary">Services</h6>
                    <div class="dropdown no-arrow">
                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                             aria-labelledby="dropdownMenuLink">
                            <div class="dropdown-header">Dropdown Header:</div>
                            <a class="dropdown-item" href="#">Action</a>
                            <a class="dropdown-item" href="#">Another action</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                    </div>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                    <div class="chart-pie pt-4 pb-2">
                       <canvas id="myPieChartInternal"></canvas>
                    </div>
                    <div class="mt-4 text-center small">
                        <span class="mr-2">
                            <i class="fas fa-circle text-primary"></i> POS
                        </span>
                        <span class="mr-2">
                            <i class="fas fa-circle text-success"></i> P2M
                        </span>
                        <span class="mr-2">
                            <i class="fas fa-circle text-info"></i> Other
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>



</div>