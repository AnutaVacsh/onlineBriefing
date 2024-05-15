import { useState, useEffect } from "react";
import UntestedBriefingList from "./UntestedBriefingList";
import UntestedStudent from './UntestedStudent';
import { Route, Routes } from "react-router-dom";
import UnchectedTest from "./UntestedTest";

function PageUntested(){
    const [subject, setSubject] = useState(sessionStorage.getItem('selectedSubjectCheck'));
    const [selectThemes, setSelectThemes] = useState(sessionStorage.getItem('selectedThemeCheck'));
    const [selectStudent, setSelectStudent] = useState(sessionStorage.getItem('selectedStudentName'));
    const [themes, setThemes] = useState([{id: 1, idSubject: 1, number: 1, title: "Пожары", status: "Открыто"}, {id: 2, idSubject: 1, number: 2, title: "Пожарыблабла", status: "Закрыто"}]);
    console.log(selectThemes);

    useEffect(() => {
        fetch("http://localhost:8080/briefing/getSubject/"+sessionStorage.getItem('idSubjectCheckTeacher'), {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setThemes(data))
        .catch((e)=> console.log(e.message))
    }, [])

    function openTheme(id){
        sessionStorage.setItem('idThemeTeacher', id);
        console.log(id)
        window.location.href = "/teacher/check/untestedBriefing/stud"
    }

    return(
        <div className="untestedBriefing">
            <h2>Непроверенные тесты</h2>
            <h2>{subject}</h2>
            <h2>{selectThemes}</h2>
            <h2>{selectStudent}</h2>
            <div className='l'></div>
            <Routes >
                <Route path='/' element = {<UntestedBriefingList setSelectedTheme = {setSelectThemes}/>}/>
                <Route path='/stud' element = {<UntestedStudent setSelectStudent = {setSelectStudent}/>}/>
                <Route path='/stud/test' element = {<UnchectedTest/>}/>
            </Routes>
        </div>
    )
}

export default PageUntested;