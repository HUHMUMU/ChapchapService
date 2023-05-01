async function addJjimList(userId,storeNum,btn){
    let url="/jjim/handler.do";
    const data=new FormData();
    let active=btn.classList.contains("active");
    if(active){
        let c=confirm("삭제하시겠습니까?");
        data.append("userId",userId);
        data.append("storeNum",storeNum);
        if(c){
            const resp=await fetch(url,{method:"DELETE",body:data});
            if(resp.status===200){
                const json=await resp.json();
                if(json.remove>0){
                    btn.classList.remove("active");
                    alert("삭제 성공!");
                }else {
                    alert("삭제 실패!(존재하지 않는 리스트!)");
                }
            }else{
                alert("삭제 실패! status : "+resp.status);
            }
        }
    }else{
        data.append("userId",userId);
        data.append("storeNum",storeNum);
        const resp=await fetch(url,{method:"POST",body:data});
        if(resp.status===200){
            const json=await resp.json();
            if(json.add>0){
                btn.classList.add("active");
                alert("추가 성공!");
            }
         }else{
            alert("추가 실패! status : "+resp.status);
        }
    }
}