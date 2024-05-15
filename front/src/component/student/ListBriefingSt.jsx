import {useState, useEffect } from "react";

function ListBriefingSt(){
    //const [listBr, setListBr] = useState([{id: 1, title: 'Безопасность жизнедеятельности (проф. 764)', prosent: 80}, {id: 2, title: 'Математика', prosent: 70}, {id: 3, title: 'Физика', prosent: 60}, {id: 1, title: 'Иностранный язык', prosent: 40}]);
    const [listBr, setListBr] = useState([]);
    const [listSub, setListSub] = useState([]);

    useEffect(() => {
        fetch("http://localhost:8080/brifing/getSubjects/1", {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setListBr(data))
        .catch((e)=> console.log(e.message))
    }, [])

  
    function openSubject(id){
        localStorage.setItem('subject', id);
        window.location.href = `student/briefing`;
    }

    function getColor(prosent){
        if(prosent >= 70) return 'green';
        else if(prosent >= 50) return 'yellow';
        return 'red';
    }

    const elBr = listBr.map((item)=> {
        return <div className="elBriefing" key = {item.id} onClick={(e) => openSubject(item.title)}>
            <p className="title">{item.title}</p>
            <p className={"prosent " + (getColor(item.prosent))}>{item.prosent + "%"}</p>
        </div>
        }
    )

    return(
        <div className="briefingSt">
            <div className="listBriefing">
                {elBr}
            </div>
        </div>
    )
}

export default ListBriefingSt;