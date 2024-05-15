import React, { useState, useEffect } from "react";

function Result() {
    const themeId = localStorage.getItem('themeId');
    //const [theme, setTheme] = useState({ title: 'Тема 2: Пожары', result: '90%', attempts: 0, status: 'Открыто' });
    const [theme, setTheme] = useState()
    //const [questions, setQuestions] = useState([{ id: 1, question: 'Номер службы пожарной охраны' }, { id: 2, question: 'Можно ли разжигать костер во дворе?' }, { id: 3, question: 'Можно ли оставлять без присмотра утюг?' }]);
    const [questions, setQuestions] = useState([])
    const [answers, setAnswers] = useState([{ id: 1, answer: '01' }, { id: 2, answer: 'да' }, { id: 3, answer: 'нет' }]);
    
    const [marks, setMarks] = useState([{id: 1, mark: '1'}, {id: 2, mark: '0'}, {id: 3, mark:'1'}]);


    useEffect(() => {
        const fetchAnswersAndMarks = async () => {
            try {
                const response = await fetch('https://localhost:8080/briefing/answerDetails'); 
                if (!response.ok) {
                    throw new Error('Failed to fetch answers and marks');
                }
                const data = await response.json();
                setAnswers(data.answers);
                setMarks(data.marks);
            } catch (error) {
                console.error('Error fetching answers and marks:', error);
            }
        };

        const fetchQuestions = async () => {
            try {
                const response = await fetch('https://localhost:8080/briefing/questions/'+themeId); 
                if (!response.ok) {
                    throw new Error('Failed to fetch questions');
                }
                const questionsData = await response.json();
                setQuestions(questionsData);
            } catch (error) {
                console.error('Error fetching questions:', error);
            }
        };

        fetchAnswersAndMarks();
        fetchQuestions();
    }, []);

    function handleSubmit(){
        window.location.href = "/student/briefing";
    }

    return (
        <><div className="header_pr">
                     <p className="title_pr">{theme.title} </p>
                    <hr className="line" />
            </div>
        <div className="testSt">
            {questions.map((item) => (
                <div className="resultAnswer" key={item.id}>
                    <div className="resultQuestion">
                    <p>Вопрос {item.id}</p>
                    <p>Балл: {marks.find(mark => mark.id === item.id)?.mark || '-'}</p>
                    </div>
                    <p className="answerRes">Ответ: {answers.find(answer => answer.id === item.id)?.answer || '-'}</p>  
                </div>
            ))}
            <button className="finishButton" onClick={handleSubmit}>Завершить</button>
        </div>
        
        </>
    );
}

export default Result;
