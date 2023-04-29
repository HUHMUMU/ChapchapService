const storeListCont=document.getElementById("storeListCont");

let mapContainer = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
let mapOptions = { //지도를 생성할 때 필요한 기본 옵션
    center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
    level: 3 //지도의 레벨(확대, 축소 정도)
};
let map = new kakao.maps.Map(mapContainer, mapOptions); //지도 생성 및 객체 리턴
let geocoder = new kakao.maps.services.Geocoder();
let bounds = new kakao.maps.LatLngBounds();

let allParam = {
    'pageNumber' : 1,
    'order' : "",
    'direct' : "",
    'menuType' : "",
    'menuName' : "",
    'priceRange' : "",
    'priceType' : "",
    'parking' : "",
    'parkingType' : ""
}
function filterResult(){ // 현재 필터된 요소 표시 버튼
    // 버튼을 추가할 부모 요소를 선택
    let parentElement = document.getElementById("filterResult");

    // 기존에 추가된 버튼들을 모두 제거
    while (parentElement.firstChild) {
        parentElement.firstChild.remove();
    }

    // allParam의 특정 키 값들을 검사하고 빈 문자열이 아닌 값을 배열에 추가
    let paramsToShow = ['menuName', 'priceType', 'parkingType'].filter(key => allParam[key]);

    // 각 값에 대해 버튼을 생성/추가 // 버튼
    paramsToShow.forEach(key => {
        let btn = document.createElement("button");
        btn.setAttribute("type", "button");
        btn.setAttribute("class", "btn btn-secondary btn-sm p-0 me-1 ms-1");
        btn.style.width = "50px";
        btn.innerText = allParam[key];

        // menuName에 대한 버튼 클릭 처리
        if (key === 'menuName') {
            btn.onclick = function() {
                allParam.menuType = "";
                allParam.menuName = "";
                loadStoreList();
            };
        }
        // priceType에 대한 버튼 클릭 처리
        else if (key === 'priceType') {
            btn.onclick = function() {
                allParam.priceType = "";
                allParam.priceRange = "";
                loadStoreList();
            };
        }
        // parkingType에 대한 버튼 클릭 처리
        else if (key === 'parkingType') {
            btn.onclick = function() {
                allParam.parkingType = "";
                allParam.parking = "";
                loadStoreList();
            };
        }
        parentElement.appendChild(btn);
    });
}

// 페이지 로드
function loadStoreList(){
    let url='/store/ajaxList.do?';

    for (const key in allParam) {
        if (allParam[key]) { // 값이 있을 경우에만 추가합니다.
            url += `&${key}=${allParam[key]}`;
        }
    }

    fetch(url)
        .then(response => response.json())
        .then(data => {
            let stores = data.list;
            storeListCont.innerHTML="";
            let positions;
            for (const store of stores){
                let coords
                // 주소로 좌표가져오기
                geocoder.addressSearch(store.address, function(result, status){
                    // 정상적으로 검색이 완료됐으면
                    if (status === kakao.maps.services.Status.OK) {
                        coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                        positions = {
                            title : store.storeName,
                            latlng: coords
                        }
                        let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
                        // 마커 이미지의 이미지 크기 입니다
                        let imageSize = new kakao.maps.Size(24, 35);
                        // 마커 이미지를 생성합니다
                        let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                        // 마커를 생성합니다
                        let marker = new kakao.maps.Marker({
                            map: map, // 마커를 표시할 지도
                            position: positions.latlng, // 마커를 표시할 위치
                            title : positions.title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                            image : markerImage // 마커 이미지
                        })
                    }
                });
                storeListCont.insertAdjacentHTML("beforeend",storeLiComponent(store));
            }
            storeListCont.insertAdjacentHTML("beforeend", pageNavComponent(data));
        });
    filterResult();
}

function getCategoryName(categoryNum) {
    switch(categoryNum) {
        case 1: return "혼밥";
        case 2: return "족발";
        case 3: return "보쌈";
        case 4: return "치킨";
        case 5: return "고기";
        case 6: return "양식";
        case 7: return "백반";
        case 8: return "일식";
        case 9: return "회";
        case 10: return "중식";
        case 11: return "아시안";
        case 12: return "패스트푸드";
        case 13: return "찜";
        case 14: return "해물";
        case 15: return "고기";
        case 16: return "돈까스";
        case 17: return "탕,찌개";
        case 20: return "국수";
        case 21: return "분식";
        case 23: return "호프집";
        case 24: return "바";
        case 25: return "이자카야";
        case 26: return "포차";
        case 27: return "와인바";
        case 29: return "커피전문점";
        case 30: return "디저트카페";
        case 31: return "차전문점";
        case 32: return "베이커리카페";
        default: return "기타"; // 혹시 모르는 다른 숫자가 들어올 경우를 대비
    }
}
function getParking(parking){
    if(parking){
        return "주차가능";
    } else {
        return "주차불가";
    }
}

function storeLiComponent(store){
    return `<div class="d-flex justify-content-center align-items-center" style="border:1px solid gray; min-width: 342px; max-width: 432px;">
                        <div class="col-4">
                            <img src="${store.mainImg}" alt="식당 대표 이미지" class="img-fluid rounded ps-1" style="min-width: 97px; max-width:127px; background-color: darkgray;">
                        </div>
                        <div class="col-5">
                            <div class="mt-2 mb-2 d-inline">
                                <h5 class="d-inline">${store.storeName}</h5>
                                <i class="bi bi-star-fill"></i>
                                <span>${store.averageStar.toFixed(2)}</span>
                            </div>
                            <p class="m-0" style="font-size: 0.875rem;">${store.shortInfo}</p>
                            <p class="mt-2 mb-2">
                                <i class="bi bi-chat-square-text"></i>
                                <span>${store.reviewCount}</span>
                                <i class="bi bi-heart ms-3"></i>
                                <span>${store.jjimCount}</span>
                            </p>
                        </div>
                        <div class="col-3 d-flex flex-column justify-content-center align-items-center">
                            <p class="d-flex rounded border border-secondary justify-content-center p-1 m-0 mb-2" style="width: 80px;">
                                <span style="font-size: 0.875rem;">Waiting</span>
                                <span style="font-size: 0.875rem;">14</span>
                            </p>
                            <p class="d-flex rounded border border-secondary justify-content-center p-1 m-0" style="width: 80px;">
                                <span style="font-size: 0.875rem;">${getCategoryName(store.categoryNum)}</span>
                            </p>
                            <p class="d-flex rounded border border-secondary justify-content-center p-1 m-0 mt-2" style="width: 80px;">
                                <span style="font-size: 0.875rem;">${getParking(store.parking)}</span>
                            </p>
                        </div>
                    </div>`
}
// 페이지 이동 URL 생성
function createPageUrl (pageNum){
    allParam.pageNumber=pageNum;
    loadStoreList();
}
function pageNavComponent(page = {}){
    // 페이지 이동 버튼 생성
    const createPageItem = (pageNum, isActive, isDisabled, isNavButton = false) => {
        let navigatePageNum;
        switch(pageNum){
            case "<<": navigatePageNum = 1; break;
            case "<": navigatePageNum = Math.max(1, parseInt(allParam.pageNumber) - 1); break;
            case ">": navigatePageNum = Math.min(page.pages, parseInt(allParam.pageNumber) + 1); break;
            case ">>": navigatePageNum = parseInt(page.pages); break;
            default: navigatePageNum = parseInt(pageNum);
        }
        return `
            <li class="page-item ${isDisabled ? 'disabled' : ''}">
                <a class="page-link text-secondary"
                   style="padding:4px 6px;"
                   href="#"
                   onclick = "createPageUrl(${navigatePageNum})"
                   class="${(navigatePageNum === parseInt(allParam.pageNumber)) ? 'active' : ''}">
                   ${pageNum}
                </a>
            </li>
        `;
    };
    return `
        <!-- class="active" 와 >> 가 작동하지않는데 그 이유를 모르겠음. -->
        <ul class="pagination justify-content-center">
            ${createPageItem("<<", parseInt(allParam.pageNumber) === 1, page.isFirstPage, true)}
            ${createPageItem("<", false, !page.hasPreviousPage, true)}
            ${page.navigatepageNums.map(h => createPageItem(h, h === parseInt(allParam.pageNumber), false)).join('')}
            ${createPageItem(">", false, !page.hasNextPage, true)}
            ${createPageItem(">>", false, !page.isLastPage, true)}
        </ul>
    `;
}

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
        // searchParams.set('order', selectedOrder);
        // searchParams.set('direct', selectedDirect);
        allParam.order = selectedOrder;
        allParam.direct = selectedDirect;
        loadStoreList(searchParams.toString());
    }
}

function setMenuType(menuType, menuTypeText) {
    allParam.menuType = menuType;
    allParam.menuName = menuTypeText;
    loadStoreList();
}

function setPriceRange(priceRangeValue, priceRangeText) {
    allParam.priceRange = priceRangeValue;
    allParam.priceType = priceRangeText;
    loadStoreList();
}

function setParking(parkingValue, parkingText){
    allParam.parking = parkingValue;
    allParam.parkingType = parkingText;
    loadStoreList();
}