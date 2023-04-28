console.log("포함됨");

let geocoder = new kakao.maps.services.Geocoder();
let callback = function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        console.log(result);
    }
};

function loadStoreList(parmas){
    let url='/store/ajaxList.do';
    if(parmas)url+="?"+parmas;
    fetch(url)
        .then(response => response.json())
        .then(data => {
            let stores = data.list;
            for (let i=0; i<stores.length; i++){
                console.log(stores[i].address);
                geocoder.addressSearch(stores[i].address, callback);
            }
        });
}

let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
let options = { //지도를 생성할 때 필요한 기본 옵션
    center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
    level: 3 //지도의 레벨(확대, 축소 정도)
};

let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

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
        loadStoreList(searchParams.toString());
        //location.href = '?' + searchParams.toString();
    }
}

function setMenuType(menuType, menuTypeText) {
    let searchParams = new URLSearchParams(window.location.search);
    searchParams.set('menuType', menuType);
    searchParams.set('menuName', menuTypeText);
    loadStoreList(searchParams.toString());

   // location.href = '?' + searchParams.toString();
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