import { useState, useEffect } from "react";

function UntestedSubject(){
    const [listBr, setListBr] = useState([]);

    useEffect(() => {
        fetch("http://localhost:8080/briefing/getSubjectsByTeacher/"+sessionStorage.getItem('idUser'), {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setListBr(data))
        .catch((e)=> console.log(e.message))
    }, [])

    function openBriefing(title, id){
        sessionStorage.setItem('selectedSubjectCheck', title);
        sessionStorage.setItem('selectedSubjectCheckId', id);
        sessionStorage.removeItem('selectedThemeCheck')
        sessionStorage.removeItem('selectedStudentCheck')
        sessionStorage.removeItem('selectedStudentName')
        window.location.href = "/teacher/check/untestedBriefing"
    }

    const elBr = listBr.map((item)=> {
        return <div className="elBriefing" key = {item.id} onClick={(e) => openBriefing(item.title, item.id)}>
            <p className="title">{item.title}</p>
        </div>
        }
    )

    return(
        <div className="briefingT">
            <div className="search"></div>
            <div className="listBriefing">
                {elBr}
            </div>
        </div>
    )
}

export default UntestedSubject;