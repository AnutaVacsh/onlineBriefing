import '../../css/briefing.css'
import { useState, useEffect } from 'react'

function BriefingSt(){
    const subject = localStorage.getItem('subject');
    localStorage.removeItem('subject');
    //const [themes, setThemes]= useState([{title: 'Тема 1: Введение', result: '70%', attempts: 0, status: 'Закрыто'}, {title: 'Тема 2: Пожары', result: '90%', attempts: 2, status: 'Открыто'}, {title: 'Тема 3: Оползни', result: '50%', attempts: 0, status: 'Закрыто'}, {title: 'Тема 4: Ураганы', result: '80%', attempts: 2, status: 'Открыто'}]);
    const [themes, setThemes]= useState([]);

    useEffect(() => {
        fetch("http://localhost:8080/getSubjects/1", {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setThemes(data))
        .catch((e)=> console.log(e.message))
    }, [])

    function openTheme(id){
        sessionStorage.setItem('themeId', id);
        sessionStorage.setItem('alert', 1);
        window.location.href = "/student/briefing/test"
    }
    
    const elT = themes.map((item)=> (
        <div className="elThemesSt" key={item.id} onClick={item.status.toLowerCase() === 'открыто' ? () => openTheme(item.id) : null} data-status={item.status}>
            <p className="theme_info_">{item.title}</p>
            <p className="theme_info">{item.result}</p>
            <p className="theme_info">{item.attempts}</p>
            <div className="status_container">
                <p className={"status " + (item.status.toLowerCase() === 'открыто' ? 'blue' : 'red')}>{item.status}</p>
            </div>
        </div>
    ));

    return(
        <div className="briefing">
            <div className="header_pr">
                <p className="title_pr">{subject} </p>
            </div>
            <div className="listThemes">
                <div className="elThemesSt">
                    <p className="theme_info_">Тема</p>
                    <p className="theme_info">Лучший результат</p>
                    <p className="theme_info">Попыток осталось</p>
                    <p className="status_container">Статус</p>
                </div>
                {elT}
            </div>
        </div>
    )
}

export default BriefingSt;
