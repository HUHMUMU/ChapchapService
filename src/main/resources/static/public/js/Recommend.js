async function toggleRecommend(storeNum,btn){//추천 토글 버튼
    let active=btn.classList.contains("active");
    if(active){
        let remove = await deleteRecommend(storeNum);
        if(remove>0){
            alert("추천이 취소되었습니다.");
            btn.classList.remove("active");
        }else {
            alert("추천 취소에 실패했습니다.");
        }
    }else{
        let add=await addRecommend(storeNum);
        if(add){
            alert("추천에 성공했습니다.");
            btn.classList.add("active");
        }else{
            alert("추천에 실패했습니다.")
        }
    }
}
async function deleteRecommend(storeNum){
    let url=`/recommend/${storeNum}/handler.do`
    const resp=await fetch(url,{method:"DELETE"});
    if(resp.status===200){
        return await resp.text();
    }else if(resp.status===400){
        alert("로그인 플리즈");
    }else if(resp.status===500){
        alert("오류고침 플리즈");
    }
}
async function addRecommend(storeNum){
    let url=`/recommend/${storeNum}/handler.do`
    const resp=await fetch(url,{method:"POST"});
    if(resp.status===200){
        return await resp.text();
    }else if(resp.status===400){
        alert("로그인 플리즈");
    }else if(resp.status===500){
        alert("오류고침 플리즈");
    }
}
