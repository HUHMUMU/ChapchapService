let mapContainer = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
let mapOptions = { //지도를 생성할 때 필요한 기본 옵션
    center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
    level: 3 //지도의 레벨(확대, 축소 정도)
};
let map = new kakao.maps.Map(mapContainer, mapOptions); //지도 생성 및 객체 리턴
let geocoder = new kakao.maps.services.Geocoder();
let bounds = new kakao.maps.LatLngBounds();
let mapTypeControl = new kakao.maps.MapTypeControl();
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
let zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);



console.log(stores);