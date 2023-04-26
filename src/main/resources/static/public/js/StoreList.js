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
    location.href = `?order=${selectedOrder}&direct=${selectedDirect}`;
    }
}

function setMenuType(menuType, menuTypeText) {
    document.getElementById('menuType').innerText = '메뉴 종류: ' + menuTypeText;
    location.href = `?menuType=${menuType}`;
}