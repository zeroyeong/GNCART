<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="auth.AuthBean"%>
<%@ page import="auth.AuthMgr"%>
<jsp:useBean id="aMgr" class="auth.AuthMgr" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String[] values = request.getParameterValues("chk");
    String[] LINE_NO;
    String[] VAC_NO;
    String[] BUS_NO;

    if (values != null && values.length > 0) {
        LINE_NO = new String[values.length];
        VAC_NO = new String[values.length];
        BUS_NO = new String[values.length];

        for (int i = 0; i < values.length; i++) {
            String[] splitValues = values[i].split(",");
            LINE_NO[i] = splitValues[0];
            VAC_NO[i] = splitValues[1];
            BUS_NO[i] = splitValues[2];
        } 

        for (int i = 0; i < values.length; i++) {
            String lineNo = LINE_NO[i];
            String vacNo = VAC_NO[i];
            String busNo = BUS_NO[i];

            if (vacNo != null) {
                int lineNoValue = Integer.parseInt(lineNo);
                int vacNoValue = Integer.parseInt(vacNo);
                aMgr.vacDelete(lineNoValue, vacNoValue);
            }

            if (busNo != null) {
                int lineNoValue = Integer.parseInt(lineNo);
                int busNoValue = Integer.parseInt(busNo);
                aMgr.busDelete(lineNoValue, busNoValue);
            }
        }

        response.sendRedirect("authHold.jsp");
    } else {
        response.sendRedirect("authHold.jsp");
    }
%>
</body>
</html>