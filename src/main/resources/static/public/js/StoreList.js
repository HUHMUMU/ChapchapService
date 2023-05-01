const storeListCont=document.getElementById("storeListCont");

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

let allParam = {
    'pageNumber' : 1,
    'order' : "",
    'direct' : "",
    'menuType' : "",
    'menuName' : "",
    'priceRange' : "",
    'priceType' : "",
    'parking' : "",
    'parkingType' : "",
    'detailArea' : "",
    'searchName' : "",
    'detailMenuName' : ""
}
function filterResult(){ // 현재 필터된 요소 표시 버튼
    // 버튼을 추가할 부모 요소를 선택
    let parentElement = document.getElementById("filterResult");

    // 기존에 추가된 버튼들을 모두 제거
    while (parentElement.firstChild) {
        parentElement.firstChild.remove();
    }

    // allParam의 특정 키 값들을 검사하고 빈 문자열이 아닌 값을 배열에 추가
    let paramsToShow = ['menuName', 'priceType', 'parkingType', 'detailArea'].filter(key => allParam[key]);

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
        // detailArea에 대한 버튼 클릭 처리
        else if (key === 'detailArea') {
            btn.onclick = function() {
                allParam.detailArea = "";
                loadStoreList();
            };
        }
        parentElement.appendChild(btn);
    });
}
// 페이지 로드
let markers = [];
function loadStoreList(search){
    let url='/store/ajaxList.do?';
    if(search){
        url+=search;
    }else{
        for (const key in allParam) {
            if (allParam[key]) { // 값이 있을 경우에만 추가합니다.
                url += `&${key}=${allParam[key]}`;
            }
        }
    }
    for (let j = 0; j < markers.length; j++) {
        markers[j].setMap(null);
    }
    markers = [];  // 마커 배열 초기화
    bounds=new kakao.maps.LatLngBounds();
    fetch(url)
        .then(response => response.json())
        .then(data => {
            let stores = data.list;
            storeListCont.innerHTML="";
            let positions=[];
            let i=0;
            for (const store of stores){
                // 주소로 좌표가져오기
                geocoder.addressSearch(store.address, function(result, status){
                    // 정상적으로 검색이 완료됐으면
                    if (status === kakao.maps.services.Status.OK) {
                        let coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                        positions[i] = {
                            title : store.storeName,
                            latlng: coords
                        }
                        let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
                        // 마커 이미지의 이미지 크기 입니다
                        let imageSize = new kakao.maps.Size(24, 35);
                        // 마커 이미지를 생성합니다
                        let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                        // 마커를 생성합니다
                        markers[i]=new kakao.maps.Marker({
                            map: map, // 마커를 표시할 지도
                            position: positions[i].latlng, // 마커를 표시할 위치
                            title: positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                            image: markerImage // 마커 이미지
                        });  // 마커를 배열에 저장

                        bounds.extend(coords);
                        function setBounds() {
                            // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
                            // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
                            map.setBounds(bounds);
                        }
                        setBounds();
                        i++;
                    }
                });
                storeListCont.insertAdjacentHTML("beforeend",storeLiComponent(store));
            }
            storeListCont.insertAdjacentHTML("beforeend", pageNavComponent(data));
        });
    filterResult();
}

loadStoreList(location.search);
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
                                <a class="d-inline text-decoration-none se2_font_size" href="/store/${store.storeNum}/detail.do">${store.storeName}</a>
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
function setOrder(order, selectedDirect) {
    if(!selectedDirect) {
        if(allParam.direct==="ASC"){
            allParam.direct="DESC";
        }
        else {
            allParam.direct="ASC";
        }
    }

    if (selectedOrder === order) {
    } else {
        selectedOrder = order;
    }

    if (selectedOrder) {
        allParam.order = selectedOrder;
        loadStoreList();
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

// 시군구
let gangwon = ["강릉시", "동해시", "삼척시", "속초시", "원주시", "춘천시", "태백시", "고성군", "양구군", "양양군", "영월군", "인제군", "정선군", "철원군", "평창군", "홍천군", "화천군", "횡성군"];
let gyeonggi = ["고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시", "가평군", "양평군", "여주군", "연천군"];
let gyeongsangnam = ["거제시", "김해시", "마산시", "밀양시", "사천시", "양산시", "진주시", "진해시", "창원시", "통영시", "거창군", "고성군", "남해군", "산청군", "의령군", "창녕군", "하동군", "함안군", "함양군", "합천군"];
let gyeongsangbuk = ["경산시", "경주시", "구미시", "김천시", "문경시", "상주시", "안동시", "영주시", "영천시", "포항시", "고령군", "군위군", "봉화군", "성주군", "영덕군", "영양군", "예천군", "울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군"];
let gwangju = ["광산구", "남구", "동구", "북구", "서구"];
let daegu = ["남구", "달서구", "동구", "북구", "서구", "수성구", "중구", "달성군"];
let daejeon = ["대덕구", "동구", "서구", "유성구", "중구"];
let busan = ["강서구", "금정구", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구", "기장군"];
let seoul = ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"];
let ulsan = ["남구", "동구", "북구", "중구", "울주군"];
let incheon = ["계양구", "남구", "남동구", "동구", "부평구", "서구", "연수구", "중구", "강화군", "옹진군"];
let jeonnam = ["광양시", "나주시", "목포시", "순천시", "여수시", "강진군", "고흥군", "곡성군", "구례군", "담양군", "무안군", "보성군", "신안군", "영광군", "영암군", "완도군", "장성군", "장흥군", "진도군", "함평군", "해남군", "화순군"];
let jeonbuk = ["군산시", "김제시", "남원시", "익산시", "전주시", "정읍시", "고창군", "무주군", "부안군", "순창군", "완주군", "임실군", "장수군", "진안군"];
let jeju = ["서귀포시", "제주시", "남제주군", "북제주군"];
let chungbuk = ["제천시", "청주시", "충주시", "괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "증평군", "진천군", "청원군"];
let chungnam = ["천안시", "공주시", "보령시", "아산시", "서산시", "논산시", "계룡시", "당진시", "금산군", "부여군", "서천군", "청양군", "홍성군", "예산군", "태안군"];
function categoryChange3(event) {
    if (!event.target.matches('.dropdown-item')) return;

    const region = event.target.getAttribute('data-value');
    const selectedText = event.target.textContent;

    const state = document.getElementById("state3");

    let add;
    if (region === "general01") {
        add = gangwon;
    } else if (region === "general02") {
        add = gyeonggi;
    } else if (region === "general03") {
        add = gyeongsangnam;
    } else if (region === "general04") {
        add = gyeongsangbuk;
    } else if (region === "general05") {
        add = gwangju;
    } else if (region === "general06") {
        add = daegu;
    } else if (region === "general07") {
        add = daejeon;
    } else if (region === "general08") {
        add = busan;
    } else if (region === "general09") {
        add = seoul;
    } else if (region === "general10") {
        add = ulsan;
    } else if (region === "general11") {
        add = incheon;
    } else if (region === "general12") {
        add = jeonnam;
    } else if (region === "general13") {
        add = jeonbuk;
    } else if (region === "general14") {
        add = jeju;
    } else if (region === "general15") {
        add = chungnam;
    } else if (region === "general16") {
        add = chungbuk;
    }

    document.getElementById("detailedArea").textContent = selectedText;

    // 기존의 <li> 태그들을 모두 삭제합니다.
    while (state.firstChild) {
        state.removeChild(state.firstChild);
    }

    // 선택한 시/도의 군/구를 <li> 태그로 만들어 추가합니다.
    for (let i = 0; i < add.length; i++) {
        let li = document.createElement("li");
        let a = document.createElement("a");
        a.classList.add("dropdown-item");
        a.href = "#";
        a.textContent = add[i];
        li.appendChild(a);
        state.appendChild(li);
    }
}
function categoryChange4(event) {
    if (!event.target.matches('.dropdown-item')) return;

    const selectedText = event.target.textContent;

    // 선택한 군/구의 텍스트로 버튼의 텍스트를 변경합니다.
    document.getElementById("detailedAreaDetail").textContent = selectedText;
    allParam.detailArea=selectedText;
    loadStoreList();
}
