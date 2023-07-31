// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});


var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(); 

var marker = new kakao.maps.Marker();

// 전주 시청 위치로 지도 초기화
var position = '전주 시청';
ps.keywordSearch(position, placesSearchCB); 

var placeName = '';
var addressName = '';

function searchPlace(){
    marker.setMap(null);

    place = document.getElementById('place').value;

	if(place == null){
		place = '전주 시청';
	}

    // 키워드로 장소를 검색합니다
    ps.keywordSearch(place, placesSearchCB); 
}

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        displayMarker(data[0]);    
        bounds.extend(new kakao.maps.LatLng(data[0].y, data[0].x));     

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {

    // 마커를 생성하고 지도에 표시합니다
    marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    var content = '<div div style="width:300px;text-align:center;padding:6px 0;">'+ place.place_name + '<br>' + place.address_name + '<br>' +'</div>';
    
    
    console.log("place.place_name = " + place.place_name);
    console.log("place.address_name = " + place.address_name);
    
    placeName = place.place_name;
    addressName = place.address_name;
    
    infowindow.setContent(content);
    infowindow.open(map, marker);
}

///여기 까지 kakaoMap

//Map 정보 저장
//condolencesAdd -> condolencesMap -> condolencesAdd
//condolencesRevise -> condolencesMap -> condolencesRevise
function sendmap(){

	window.opener.document.getElementById("locationId").value = addressName;
	window.opener.document.getElementById("kakaoField").value = placeName + " / " + addressName;
	self.close();
}

//엔터 누르면 서치
var place = document.getElementById("place");

place.addEventListener("keydown", function (event) {
  if (event.keyCode === 13) {
    event.preventDefault();
    document.getElementById("searchBtn").click();
  }
});


