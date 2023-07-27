$(document).ready(function () {
    $('#example').DataTable({
        "language": {
            "decimal":        "",
            "emptyTable":     "등록된 게시글이 없습니다.",
            "info":           "최근 등록된 _END_개의 게시글 (총 게시글 수 _TOTAL_개)",
            "infoEmpty":      "0 개 항목 중 0 ~ 0 개 표시",
            "infoFiltered":   "(_MAX_ 총 항목에서 필터링 됨)",
            "infoPostFix":    "",
            "thousands":      ",",
            "lengthMenu":     "_MENU_개씩 보기",
            "loadingRecords": "로드 중 ...",
            "processing":     "처리 중 ...",
            "search":         "검색:",
            "zeroRecords":    "일치하는 검색결과가 없습니다",
            "paginate": {
                "first":      "처음",
                "last":       "마지막",
                "next":       "다음",
                "previous":   "이전"
            }}
    });
});