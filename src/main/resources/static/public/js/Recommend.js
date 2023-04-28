const recommend=document.getElementById("Recommend");

async function removeRecommend(userId,storeNum){
    let c=confirm("삭제하시겠습니까?");
    let url="/recommend/handler.do";
    const data=new FormData();
    data.append("userId",userId);
    data.append("storeNum",storeNum);
    if(c){
        const resp=await fetch(url,{method:"DELETE",body:data});
        if(resp.status===200){
            const json=await resp.json();
            if(json.remove>0){
                alert("삭제 성공");
                loadRecommends(userId);
            }else{
                alert("삭제 실패(이미 삭제됨)");
            }
        }else{
            alert("삭제 실패 status :"+resp.status);
        }
    }
}

async function addRecommend(userId,storeNum){
    let url="/recommend/handler.do";
    const data=new FormData();
    data.append("userId",userId);
    data.append("storeNum",storeNum);
    const resp=await fetch(url,{method:"POST",body:data});
    if(resp.status===200){
        const json=await resp.json();
        if(json.add>0){
            alert("추가 성공!");
        }else{
            alert("추가 실패!");
        }
    }else{
        alert("추가 실패 status : "+resp.status);
    }
}

async function loadRecommends(userId){
    let url=`/recommend/${userId}/list.do`;
    const resp=await fetch(url);
    if(resp.status===200){
        alert("재로드 성공!");
        let text=await resp.text();
        // console.log(text);
        recommend.innerHTML=text;
    }
}

// async function toggleRecomend(userId,storeNum,btn){
//     let active=(btn.classList.contains("active"));
//     if(active){
//
//     }
// }

// async function removeToggleAndRecommend(userId,storeNum){
//     let c=confirm("삭제하시겠습니까?");
//     let url="/recommend/handler.do";
//     const data=new FormData();
//     data.append("userId",userId);
//     data.append("storeNum",storeNum);
//     if(c){
//         const resp=await fetch(url,{method:"DELETE",body:data});
//         if(resp.status===200){
//             const json=await resp.json();
//             if(json.remove>0){
//                 alert("삭제 성공");
//                 loadRecommends(userId);
//             }else{
//                 alert("삭제 실패(이미 삭제됨)");
//             }
//         }else{
//             alert("삭제 실패 status :"+resp.status);
//         }
//     }
// }