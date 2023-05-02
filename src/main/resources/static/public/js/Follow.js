
async function FollowListToggle(toId,btn){//팔로우 이외 페이지에서 팔로우 등록
    let active=btn.classList.contains("active");//팔로우중인지 검사
    if(active){//팔로우중이라면
       let status=await removeFollow(toId);//삭제 신청할거임
        if(status===1){
            btn.classList.remove("active");
            alert("팔로우 해제 성공");
        }else{
            alert("팔로우 해제 실패");
        }
    }else{//팔로우중이 아니라면
        let status=await registerFollow(toId);//등록신청할거임
        if(status==="1"){
            btn.classList.add("active");
            alert("팔로우 성공");
        }else{
            alert("팔로우 실패");
        }
    }
}

async function registerFollow(toId,follower){
    let url=`/follow/${toId}/handler.do`;
    const resp=await fetch(url,{method:"POST"});
    if(resp.status===200){
        let status=await resp.text(); //"0" or "1"
        return status;
    }else if(resp.status===400){
        alert("로그인 하셔야 이용할 수 있는 서비스 입니다.");
    }else if(resp.status===500){//팔로잉 했는데 한번더 팔로잉하면 db 오류 발생 or db 통신오류
        alert("이미 팔로잉되었거나 오류가 발생했으니 새로고침하고 다시 시도하세요");
    }
}
async function removeFollow(fromId,follower){
    //follower : true(팔로워에서팔로우삭제), false(팔로잉삭제)
    let url=`/follow/${fromId}/handler.do`;
    const resp=await fetch(url,{method:"DELETE"});
    if(resp.status===200){
        return await resp.text();// 0 실패, 1성공
    }else if(resp.status===400){
        alert("로그인 하셔야 이용할 수 있는 서비스 입니다.");
    }else if(resp.status===500){//팔로잉 했는데 한번더 팔로잉하면 db 오류 발생 or db 통신오류
        alert("오류가 발생했으니 새로고침하고 다시 시도하세요");
    }
}
async function toggleFollower(fromId,btn){//나를 팔로우하고 있는 팔로워 유저 목록에 있는 토글
    let active=(btn.classList.contains("active"));//팔로우중인지 확인
    alert("분기1 : 팔로워");
    if(active){//이미 팔로우중이라면
        alert("팔로우중! 팔로우를 해제합니다.");
        let remove=await removeFollow(fromId);//fromId의 팔로우 삭제 신청
        if(remove>0){
            btn.classList.remove("active");
            alert("팔로워 팔로우 해제 성공!");

        }else{
            alert("팔로워 팔로우 해제 실패!");
        }
    }else{//팔로우중이 아니라면
        alert("팔로우중 아님! 팔로우를 신청합니다.")
        let register=await registerFollow(fromId);//fromId의 팔로우 등록 신처
        if(register>0){
            btn.classList.add("active");
            alert("팔로워 등록 성공");

        }else{
            alert("팔로워 등록 실패");
        }
    }
}


async function toggleFollowing(toId,btn){//내가 팔로우하고 있는 팔로잉 유저 목록에 있는 삭제 버튼
    let check=btn.classList.contains("active");
    if(check){
        alert("팔로우를 취소합니다.");
        let remove=await removeFollow(toId);//toId의 팔로우 삭제 신청
        if(remove>0){
            btn.classList.remove("active");
            alert("팔로잉 취소 성공");
        }else {
            alert("팔로잉 취소 실패");
        }
    }else{
        alert("팔로우를 다시 등록합니다.");
        let register=await registerFollow(toId);
        if(register>0){
            btn.classList.add("active");
            alert("팔로우 재등록 성공!");
        }else{
            alert("팔로우 재등록 실패");
        }
    }

}



