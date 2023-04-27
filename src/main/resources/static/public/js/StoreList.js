console.log("포함됨");

let mapOptions = {
    // 지도 중앙 위치 : 위도, 경도 설정
    center : new naver.maps.LatLng( 37.5782709, 126.9770043 ),

    // 줌 설정 : 1~14, 수치가 클수록 지도 확대(줌인), 이 옵션 생략시 기본값 9
    zoom : 14,

    // 줌 컨트롤 표시, 지정하지 않으면 false 가 기본값
    zoomControl : true,

    // 줌 컨트롤 오른쪽 위로 위치 설정
    zoomControlOptions : {
        position : naver.maps.Position.TOP_RIGHT // 오른쪽 위로 설정
    },
};
let map = new naver.maps.Map('map', mapOptions);

let selectedOrder = "";
function setOrder(order, selectedDirect="ASC") {
    if(!selectedDirect)selectedDirect="ASC";
    if (selectedDirect === "ASC"){
        selectedDirect = "DESC";

    }else if(selectedDirect === "DESC"){
        selectedDirect = "ASC";
    }
    if (selectedOrder === order) {
    } else {
        selectedOrder = order;
    }

    if (selectedOrder) {
        let searchParams = new URLSearchParams(window.location.search);
        searchParams.set('order', selectedOrder);
        searchParams.set('direct', selectedDirect);
        location.href = '?' + searchParams.toString();
    }
}

function setMenuType(menuType, menuTypeText) {
    let searchParams = new URLSearchParams(window.location.search);
    searchParams.set('menuType', menuType);
    searchParams.set('menuName', menuTypeText);
    location.href = '?' + searchParams.toString();
}

function setPriceRange(priceRangeValue, priceRangeText) {
    let priceRangeFilter = priceRangeValue;
    let searchParams = new URLSearchParams(window.location.search);
    searchParams.set('priceRange', priceRangeFilter);
    searchParams.set('priceType', priceRangeText);
    location.href = '?' + searchParams.toString();
}

function setParking(parkingValue, parkingText){
    let parkingValueFilter = parkingValue;
    let searchParams = new URLSearchParams(window.location.search);
    searchParams.set('parking', parkingValueFilter);
    searchParams.set('parkingType', parkingText);
    location.href = '?' + searchParams.toString();
}