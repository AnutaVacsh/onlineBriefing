import { useState } from "react";

function UnchectedTest(){
    const [student, setStudent] = useState([]);
    const [briefing, setBriefing] = useState([]);

    const mark = [];


    function plagiat(id){
        console.log("hghghgh")
        let item = student.find(item => item.id == id)
        return 'похоже на отает ' + item.surname +" "+ item.name+" "+ item.patronymic
    }

    function sefe(e){
        e.preventDefault();
        console.log(mark)
        fetch("http://localhost:8080/briefing/editState/", {
            method: "POST",
            headers: {"Content-Type":"application/json"},
            body: JSON.stringify(mark)
        })
        .then(()=>{console.log("edit state")})
        .catch((e)=> console.log(e.message));

        window.location.href = "/teacher/check/untestedBriefing/stud"
    }

    const elQuest = briefing.map((item, count) => 
        <div className='elQuestionCheck' key = {count}>
            <div className='left'>
                <p>{count+1+'. '+item.question}</p>
                <p className='red'>{item.plagiat>=0 && plagiat(item.plagiat)}</p>
                <div className='answer'>
                    <p>{item.answer}</p>
                </div>
            </div>
            <div className='mark'>
                <p>Оценка</p>
                <input className='short' type="number" name="mark" min ='0' max ='1' onChange={e => {mark[count] = {id_answer_student: item.id_answer_student,accuracy_percent: e.target.value}}}/>
            </div>
        </div>
        )

    return(
        <div>
            {elQuest}
            <div className="blueButton short">
                <a href="#" className="" onClick={e => sefe(e)}>Готово</a>
            </div>
        </div>
    )
}

export default UnchectedTest;