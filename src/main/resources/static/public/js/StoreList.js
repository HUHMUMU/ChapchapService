console.log("포함됨");

var mapOptions = {
    center: new naver.maps.LatLng(37.3595704, 127.105399),
    zoom: 14
};
var map = new naver.maps.Map('map', mapOptions);

let selectedOrder = "";
let selectedDirect = "ASC";

function setOrder(order) {
    selectedOrder = order;
    selectedDirect = (selectedDirect === "ASC") ? "DESC" : "ASC";
}

function applySort() {
    if (selectedOrder) {
        let searchParams = new URLSearchParams(window.location.search);
        searchParams.set('order', selectedOrder);
        searchParams.set('direct', selectedDirect);
        location.href = '?' + searchParams.toString();
    }
}

function setMenuType(menuType, menuTypeText) {
    document.getElementById('menuType').innerText = menuTypeText;
    let searchParams = new URLSearchParams(window.location.search);
    searchParams.set('menuType', menuType);
    searchParams.set('menuName', menuTypeText);
    location.href = '?' + searchParams.toString();
}

function setPriceRange(priceRangeValue, priceRangeText) {
    document.getElementById('menuType').innerText = priceRangeText;
    let priceRangeFilter = priceRangeValue;
    let searchParams = new URLSearchParams(window.location.search);
    searchParams.set('priceRange', priceRangeFilter);
    location.href = '?' + searchParams.toString();
}

function setParking(parkingValue, parkingText){
    document.getElementById('menuType').innerText = parkingText;
    let parkingValueFilter = parkingValue;
    let searchParams = new URLSearchParams(window.location.search);
    searchParams.set('parking', parkingValueFilter);
    location.href = '?' + searchParams.toString();
}