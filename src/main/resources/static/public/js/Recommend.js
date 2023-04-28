// const recommend=document.getElementById("recommendList");
//
// async function removeRecommend(userId){
//     let c=confirm("삭제하시겠습니까?");
//     let url="/recommend/handler.do";
//     if(c){
//         const resp=await fetch(url,{method:"DELETE"});
//         if(resp===200){
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
//
// async function addRecommend(userId){
//     let url="/recommend/handler.do";
//     const resp=await fetch(url,{method:"POST"});
//     if(resp.status===200){
//         const json=await resp.json();
//         if(json.add>0){
//             alert("추가 성공!");
//         }else{
//             alert("추가 실패!");
//         }
//     }else{
//         alert("추가 실패 status : "+resp.status);
//     }
// }
//
//
//
// async function loadRecommends(userId){
//     let url=`/recommend/${userId}/list.do`;
//     const resp=await fetch(url);
//     if(resp.status===200){
//         alert("재로드 성공!");
//         let text=await resp.text();
//         recommend.innerHTML=text;
//     }
// }
