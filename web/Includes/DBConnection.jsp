<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %> 
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
<sql:setDataSource var = "ALBMOSDB" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                   url = "jdbc:sqlserver://localhost;databaseName=MOSQAT"
                   user = "sa"  password = "@rvin1120"/>




<sql:setDataSource var = "ALBMOSDB" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                   url = "jdbc:sqlserver://localhost;databaseName=MOSQAT"
                   user = "sa"  password = "sql"/>
<sql:setDataSource var = "ALBMOSDB" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                   url = "jdbc:sqlserver://localhost;databaseName=MOSQAT"
                   user = "sa"  password = "@rvin1120"/>

<sql:setDataSource var = "ALBMOSDB" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                   url = "jdbc:sqlserver://localhost;databaseName=MOS"
                   user = "sa"  password = "@rvin1120"/>


<sql:setDataSource var = "ALBMOSDB" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                   url = "jdbc:sqlserver://localhost;databaseName=MOSDEV"
                   user = "sa"  password = "sql"/>
--%>

<sql:setDataSource var = "ALBMOSDB" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                   url = "jdbc:sqlserver://10.232.236.51;databaseName=MOSQAT"
                   user = "sa"  password = "@rvin1120"/>