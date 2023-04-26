console.log("포함됨");

var mapOptions = {
    center: new naver.maps.LatLng(37.3595704, 127.105399),
    zoom: 14
};
var map = new naver.maps.Map('map', mapOptions);

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