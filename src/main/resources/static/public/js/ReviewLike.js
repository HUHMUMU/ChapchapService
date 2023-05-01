async function reviewLikeHandler(rlStatus,reviewNum){
    const likeCont=document.getElementById("likeCont"+reviewNum);
    console.log(likeCont);
    let url=`/store/like/${rlStatus}/${reviewNum}/handler.do`
    const resp=await fetch(url);
    if(resp.status===200){
        const json=await resp.json();
        if (json.handler>0){
            let html=await readLike(reviewNum);
            if(html){
                likeCont.innerHTML=html;
                alert(json.status+" "+json.handlerType+" 성공");
            }else{
                alert(json.status+" "+json.handlerType+" 성공(새로고침해주세요)"); //(불러오기 실패 새로고침)
            }
        }else{
            alert(json.status+" "+json.handlerType+" 실패");
        }
    }else if(resp.status===400){
        alert("로그인 하셔야 이용 가능한 서비스 입니다.(잘못된 요청)")
    }else{
        alert("실패 status:"+resp.status);
    }
}
async function readLike(reviewNum){
    let url=`/store/like/${reviewNum}/read.do`;
    const resp=await fetch(url);
    if(resp.status===200){
        const html=await resp.text();
        return html;
    }
}