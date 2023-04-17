<%-- 
    Document   : dashboard
    Created on : 01 4, 21, 11:06:56 AM
    Author     : IT-Programmer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" >
    <script>

    </script>
    <head>
        <title>AllBank MOS - Dashboard</title>

        <%@ include file="Includes/links.jsp" %>

    </head>

    <body id="page-top">

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <%@ include file="Includes/sidebar.jsp" %>

            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <c:choose>
                        <c:when test="${UserType eq 1}">
                            <c:choose>
                                <c:when test="${USERGROUP == 4}">
                                    <%@ include file="MerchantsView/Dashboard.jsp" %>
                                </c:when>
                                <c:otherwise>
                                    <script>
                                        window.location.href = "TransactionLists.jsp";
                                    </script>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:when test="${UserType eq 0}">
                            <%@ include file="InternalView/Dashboard.jsp" %>
                        </c:when>
                    </c:choose>
                </div>
                <!-- End of Main Content -->

                <!-- Footer -->
                <footer class="sticky-footer bg-white">
                    <div class="container my-auto">
                        <div class="copyright text-center my-auto">
                            <span>Copyright &copy; portal.allbank.ph 2021</span>
                        </div>
                    </div>
                </footer>
                <!-- End of Footer -->

            </div>
            <!-- End of Content Wrapper -->

        </div>
        <!-- End of Page Wrapper -->

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>

        <!-- Logout Modal-->
        <%@ include file="Includes/LogoutModal.jsp" %>
        <%@ include file="Includes/ChangePasswordModal.jsp" %>

        <%@ include file="Includes/scripts.jsp" %>
        <c:choose>
            <c:when test="${UserType eq 1}">
                <script src="js/dashboard.js"></script>
                <script>
                                        $(document).ready(function () {
                                            //Area Chart
                                           
                                            //Pie Chart



                                        });
                </script>
            </c:when>
            <c:when test="${UserType eq 0}">

                <script>
                    $(document).ready(function () {
                        //Area Chart
                        $.ajax({url: 'AreaChartTransactions',
                            type: 'POST',
                            data: {EDate: '2021-02-28', AccountNumber: '002,20-00001-0', AreaChartType: "Internal"},
                            success: function (data) {
                                var result = data.split(";;");
                                var MonthYear = result[0].split(',');
                                var DataValues = result[1].split(',');
                                var ctx2 = document.getElementById("myAreaChartInternal");
                                var myLineChart2 = new Chart(ctx2, {
                                    type: 'line',
                                    data: {
                                        labels: MonthYear,
                                        datasets: [{
                                                label: "Onboarded",
                                                lineTension: 0.3,
                                                backgroundColor: "rgba(78, 115, 223, 0.05)",
                                                borderColor: "rgba(78, 115, 223, 1)",
                                                pointRadius: 3,
                                                pointBackgroundColor: "rgba(78, 115, 223, 1)",
                                                pointBorderColor: "rgba(78, 115, 223, 1)",
                                                pointHoverRadius: 3,
                                                pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
                                                pointHoverBorderColor: "rgba(78, 115, 223, 1)",
                                                pointHitRadius: 10,
                                                pointBorderWidth: 2,
                                                data: DataValues
                                            }]
                                    },
                                    options: {
                                        maintainAspectRatio: false,
                                        layout: {
                                            padding: {
                                                left: 10,
                                                right: 25,
                                                top: 25,
                                                bottom: 0
                                            }
                                        },
                                        scales: {
                                            xAxes: [{
                                                    time: {
                                                        unit: 'date'
                                                    },
                                                    gridLines: {
                                                        display: false,
                                                        drawBorder: false
                                                    },
                                                    ticks: {
                                                        maxTicksLimit: 7
                                                    }
                                                }],
                                            yAxes: [{
                                                    ticks: {
                                                        maxTicksLimit: 5,
                                                        maxTicksLimit: 5,
                                                        padding: 10,
                                                        // Include a dollar sign in the ticks
                                                        callback: function (value, index, values) {
                                                            return '' + number_format(value);//add p if peso
                                                        }
                                                    },
                                                    gridLines: {
                                                        color: "rgb(234, 236, 244)",
                                                        zeroLineColor: "rgb(234, 236, 244)",
                                                        drawBorder: false,
                                                        borderDash: [2],
                                                        zeroLineBorderDash: [2]
                                                    }
                                                }],
                                        },
                                        legend: {
                                            display: false
                                        },
                                        tooltips: {
                                            backgroundColor: "rgb(255,255,255)",
                                            bodyFontColor: "#858796",
                                            titleMarginBottom: 10,
                                            titleFontColor: '#6e707e',
                                            titleFontSize: 14,
                                            borderColor: '#dddfeb',
                                            borderWidth: 1,
                                            xPadding: 15,
                                            yPadding: 15,
                                            displayColors: false,
                                            intersect: false,
                                            mode: 'index',
                                            caretPadding: 10,
                                            callbacks: {
                                                label: function (tooltipItem, chart) {
                                                    var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
                                                    return datasetLabel + ': ' + number_format(tooltipItem.yLabel);
                                                }
                                            }
                                        }
                                    }
                                });

                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                console.log("Error!  Dashboard : " + thrownError);
                            }
                        });
                        //PieChart
                        $.ajax({
                            url: 'PieChartTransactions',
                            type: 'POST',
                            data: {PieChartType: "Internal"},
                            success: function (data) {

                                var result = data.split(";;");
                                // Set new default font family and font color to mimic Bootstrap's default styling
                                Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
                                Chart.defaults.global.defaultFontColor = '#858796';

                                // Pie Chart Example

                                var ctx = document.getElementById("myPieChartInternal");
                                var myPieChart = new Chart(ctx, {
                                    type: 'doughnut',
                                    data: {
                                        labels: ["P2M", "POS"],
                                        datasets: [{
                                                data: result,
                                                backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc'],
                                                hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
                                                hoverBorderColor: "rgba(234, 236, 244, 1)"
                                            }]
                                    },
                                    options: {
                                        maintainAspectRatio: false,
                                        tooltips: {
                                            backgroundColor: "rgb(255,255,255)",
                                            bodyFontColor: "#858796",
                                            borderColor: '#dddfeb',
                                            borderWidth: 1,
                                            xPadding: 15,
                                            yPadding: 15,
                                            displayColors: false,
                                            caretPadding: 10
                                        },
                                        legend: {
                                            display: false
                                        },
                                        cutoutPercentage: 80
                                    }
                                });

                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                console.log("Error!  Dashboard : " + thrownError);
                            }
                        });


                    });
                </script>
            </c:when>
        </c:choose>


    </body>

</html>