const storeListCont=document.getElementById("storeListCont");

let geocoder = new kakao.maps.services.Geocoder();
let callback = function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        console.log(result);
    }
};

let searchParams = new URLSearchParams(window.location.search);
function loadStoreList(params){
    let url='/store/ajaxList.do';
    if(params)url += "?" + params;

    fetch(url)
        .then(response => response.json())
        .then(data => {
            let stores = data.list;
            storeListCont.innerHTML="";

            for (const store of stores){
                console.log(store);
                geocoder.addressSearch(store.address, callback);
                storeListCont.insertAdjacentHTML("beforeend",storeLiComponent(store,params));
            }
        });
    // location.href = '?' + params;
}
function storeLiComponent(store,params){
    return `<div class="d-flex justify-content-center align-items-center" style="border:1px solid gray; min-width: 342px; max-width: 432px;">
                        <div class="col-4">
                            <img src="${store.list.mainImg}" alt="식당 대표 이미지" class="img-fluid rounded ps-1" style="min-width: 97px; max-width:127px; background-color: darkgray;">
                        </div>
                        <div class="col-5">
                            <div class="mt-2 mb-2 d-inline">
                                <h5 class="d-inline">${store.list.storeName}</h5>
                                <i class="bi bi-star-fill"></i>
                                <span>${#numbers.formatDecimal(store.list.averageStar, 1, 2)}</span>
                            </div>
                            <p class="m-0" style="font-size: 0.875rem;">닭갈비의 정석</p>
                            <p class="mt-2 mb-2">
                                <i class="bi bi-chat-square-text"></i>
                                <span>8</span>
                                <i class="bi bi-heart ms-3"></i>
                                <span>1</span>
                            </p>
                        </div>
                        <div class="col-3 d-flex flex-column justify-content-center align-items-center">
                            <p class="d-flex rounded border border-secondary justify-content-center p-1 m-0 mb-2" style="width: 80px;">
                                <span style="font-size: 0.875rem;">Waiting</span>
                                <span style="font-size: 0.875rem;">14</span>
                            </p>
                            <p class="d-flex rounded border border-secondary justify-content-center p-1 m-0" style="width: 80px;">
                
                                <span style="font-size: 0.875rem;">일식</span>
 
                            </p>
                            <p class="d-flex rounded border border-secondary justify-content-center p-1 m-0 mt-2" style="width: 80px;">
                                <span style="font-size: 0.875rem;">주차가능</span>
                            </p>
                        </div>
                    </div>`
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
        // let searchParams = new URLSearchParams(window.location.search);
        searchParams.set('order', selectedOrder);
        searchParams.set('direct', selectedDirect);
        loadStoreList(searchParams.toString());
    }
}

function setMenuType(menuType, menuTypeText) {
    // let searchParams = new URLSearchParams(window.location.search);
    searchParams.set('menuType', menuType);
    searchParams.set('menuName', menuTypeText);
    loadStoreList(searchParams.toString());
}

function setPriceRange(priceRangeValue, priceRangeText) {
    let priceRangeFilter = priceRangeValue;
    // let searchParams = new URLSearchParams(window.location.search);
    searchParams.set('priceRange', priceRangeFilter);
    searchParams.set('priceType', priceRangeText);
    loadStoreList(searchParams.toString());
}

function setParking(parkingValue, parkingText){
    let parkingValueFilter = parkingValue;
    // let searchParams = new URLSearchParams(window.location.search);
    searchParams.set('parking', parkingValueFilter);
    searchParams.set('parkingType', parkingText);
    loadStoreList(searchParams.toString());
    // location.href = '?' + searchParams.toString();
}