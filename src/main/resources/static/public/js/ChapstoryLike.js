async function chapLikeHandler(cNum){
    const likeCont=document.getElementById("likeCont"+cNum);
    console.log(likeCont);
    let url=`/chapstory/like/${cNum}/handler.do`
    let url2=`/chapstory/like/${cNum}/read.do`;
    const resp=await fetch(url);
    if(resp.status===200){
        const json=await resp.json();
        if(!json.handler){
            alert("성공")
            return resp;
        }else{
            alert(json.status+" "+json.handlerType+" 실패")
        }
    }else if(resp.status===400){
        alert("로그인 하셔야 이용 가능한 서비스입니다. (잘못된 요청)")
    }else{
        alert("실패 status:"+resp.status)
    }
}

// async function readLike(cNum){
//     let url=`/chapstory/like/${cNum}/read.do`;
//     const resp=await fetch(url);
//     if(resp.status===200){
//         const html=await resp.text();
//         return html;
//     }
// }