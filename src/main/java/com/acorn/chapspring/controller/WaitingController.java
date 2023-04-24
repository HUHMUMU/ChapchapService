//package com.acorn.chapspring.controller;
//
//import com.acorn.chapspring.dto.WaitingDto;
//import com.acorn.chapspring.service.WaitingService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//
//@Controller
//@RequiredArgsConstructor
//public class WaitingController {
//    private final WaitingService waitingService;
//    @get
//
//    const $('#waitingModal').on('show.bs.modal', function (event) {
//        var button = $(event.relatedTarget);
//        var maxPeople = button.data('max-people');
//        var modal = $(this);
//
//        modal.find('#maxPeople').text(maxPeople);
//
//        // 드롭다운 리스트를 동적으로 생성합니다.
//        var peopleSelect = modal.find('#peopleSelect');
//        peopleSelect.empty();
//        for (var i = 1; i <= maxPeople; i++) {
//            peopleSelect.append('<option value="' + i + '">' + i + '명</option>');
//        }
//    });
//
//    // 대기 등록 버튼을 클릭했을 때 실행될 함수입니다.
//    function registerWaiting() {
//        var people = $('#peopleSelect').val();
//        var restaurantId = getRestaurantId(); // 해당 함수는 이전에 구현한 함수로, 로그인한 사용자의 레스토랑 ID를 가져옵니다.
//
//        // 서버로 보낼 데이터를 객체 형태로 생성합니다.
//        var data = {
//                restaurantId: restaurantId,
//                people: people
//  };
//
//        //
//    }
//}
//// 모달창이 열릴 때마다 max_people 값을 가져와서 드롭다운 리스트를 동적으로 생성합니다.
//
//
//// 여기 이어서 보완 수정해야함222