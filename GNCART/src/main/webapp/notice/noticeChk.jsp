<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeBean"%>
<%@ page import="notice.NoticeMgr"%>
<jsp:useBean id="nMgr" class="notice.NoticeMgr" />
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
        String[] NOT_NO;
        String[] MEM_ID;

        if (values != null && values.length > 0) {
            NOT_NO = new String[values.length];
            MEM_ID = new String[values.length];

            // values 배열에서 NOT_NO와 MEM_ID를 추출하여 배열에 저장
            for (int i = 0; i < values.length; i++) {
                String[] splitValues = values[i].split(",");
                NOT_NO[i] = splitValues[0];
                MEM_ID[i] = splitValues[1];
            }

            NoticeMgr Mgr = new NoticeMgr();

            // 세션의 idKey 값 가져오기
            String idKey = (String) session.getAttribute("memId");

            // idKey 값과 MEM_ID[i] 값 비교하여 삭제 여부 결정
            boolean canDelete = true;
            for (int i = 0; i < MEM_ID.length; i++) {
                if (idKey == null || !idKey.equals(MEM_ID[i])) {
                    canDelete = false;
                    break;
                }
            }

            if (canDelete) {
                // 삭제 진행

                // res 변수 초기화
                int res = 0;

                if (NOT_NO.length > 0) {
                    res = Mgr.noticeCheck(NOT_NO);
                }

                if (res == NOT_NO.length) {
                    // 선택된 게시글이 모두 삭제된 경우
    %>
	<script type="text/javascript">
        alert("선택된 게시글이 삭제되었습니다.");
        location.href = "notice.jsp";
        </script>
	<%
                } else {
                    // 선택된 게시글이 삭제되지 않은 경우
    %>
	<script type="text/javascript">
        alert("선택된 게시글이 삭제되지 않았습니다.");
        location.href = "notice.jsp"; 
        </script>
	<%
                }
            } else {
                // 삭제 권한이 없는 경우
    %>
	<script type="text/javascript">
        alert("본인이 작성한 게시글만 삭제가 가능합니다.");
        location.href = "notice.jsp";
        </script>
	<%
            }
        } else {
            // 선택된 게시글이 없는 경우에 대한 처리
    %>
	<script type="text/javascript">
        alert("선택된 게시글이 없습니다.");
        location.href = "notice.jsp";
        </script>
	<%
        }
    %>
</body>
</html>