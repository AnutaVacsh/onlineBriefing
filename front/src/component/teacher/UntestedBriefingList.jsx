import { useContext, useState, useEffect } from "react";
import { Route, Routes } from "react-router-dom";

function UntestedBriefingList({setSelectedTheme}){
    const [subject, setSubject] = useState({});
    const [themes, setThemes] = useState([]);
    console.log(sessionStorage.getItem('idSubjectTeacher'));

    useEffect(() => {
        fetch("http://localhost:8080/Hall/allHall", {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setThemes(data))
        .catch((e)=> console.log(e.message))
    }, [])
    useEffect(() => {
        fetch("http://localhost:8080/briefing/getBriefings/"+ sessionStorage.getItem('idSubjectTeacher'), {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setThemes(data))
        .catch((e)=> console.log(e.message))
    }, [])

    function openTheme(title, id){
        sessionStorage.setItem('selectedThemeCheck', title);
        sessionStorage.setItem('selectedThemeCheckId', title);
        window.location.href = "/teacher/check/untestedBriefing/stud"
    }

    const elT = themes.map((item)=> {
        return <div className="elThemesUntest" key = {item.id} onClick={(e) => openTheme("Тема "+ item.number + ": "  + item.title, item.id)}>
            <p className="title">{"Тема "+ item.number + ": "  + item.title}</p>
        </div>
        }
    )

    return(
        <div className="untestedBriefing">
            <div className="listThemes">
                {elT}
            </div>
        </div>
    )
}

export default UntestedBriefingList;