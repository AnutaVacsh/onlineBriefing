import { useState } from "react"
import { Link } from "react-router-dom";

function NewBriefing(){
    class Question {
        text;
        type_verification;
        answer;
        id_briefing
    }

    const [elQuestion, setEl] = useState([new Question()]);
    const [el, set] = useState(0);

    const briefing = {
        id_subject: Number(sessionStorage.getItem('idSubjectTeacher')),
        number: null,
        title: null,
        duration: null,
        status: null
    }

    function add(){
        let temp = elQuestion
        console.log(temp)
        temp.push(new Question())
        setEl(temp)
        el == 0 ? set(1) : set(0)
    }
    function safe(){
        fetch("http://localhost:8080/briefing/addBriefing", {
                method: "POST",
                headers: {"Content-Type":"application/json"},
                body: JSON.stringify(briefing)
            })
            .then(()=>{console.log("Add Briefing")})
            .catch((e)=> console.log(e.message))

        fetch("http://localhost:8080/briefing/addAllQuestionForBriefing", {
                method: "POST",
                headers: {"Content-Type":"application/json"},
                body: JSON.stringify(elQuestion)
            })
            .then(()=>{console.log("Add Briefing")})
            .catch((e)=> console.log(e.message))
    }

    let elQues = elQuestion.map((item, count) => 
        <div className="elQuestion" key={count}>
            <p>{count+1+'.'}</p>
            <textarea placeholder="Текст вопроса" onChange = {e => elQuestion[count].text = e.target.value}></textarea>
            <textarea placeholder="Правильный ответ если есть" onChange = {e => elQuestion[count].answer = e.target.value}></textarea>
            <select className='short' name="type" onChange = {e => elQuestion[count].type = e.target.value} >
                <option value="h">вручную</option>
                <option value="a">автоматически</option>
            </select>
            {console.log(elQuestion)}
        </div>
    )
    

    return(
        <div className="newBriefing">
            <div className="line">
                <h2>Новая летучка</h2>
                <div></div>
            </div>
            <div className="form">
                <div className="top">
                    <div className="title">
                        <p>Название</p>
                        <input className='long' type="text" name="title" onChange={e => {briefing.title = e.target.value}}/>
                    </div>
                    <div className="time">
                        <p>Время</p>
                        <input className='short' type="number" name="time" min='0' max={new Date().getFullYear()} onChange={e => {briefing.title = e.target.value}}/>
                    </div>
                </div>
                <div className="cuestion">
                    <p>Вопросы</p>
                    {elQues}
                </div>
                <div className="addQuestion" onClick={add}></div>
            </div>
            <div className="blueButton">
                <Link to="/teacher/briefing" className={'user'} onClick = {(e) => safe}>Сохранить</Link>
            </div>
        </div>
    )
}

export default NewBriefing