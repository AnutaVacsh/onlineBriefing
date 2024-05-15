import React, { useState, useEffect, useRef } from "react";

function TestSt() {
    const themeId = localStorage.getItem('themeId');
    const [theme, setTheme] = useState({ title: 'Тема 2: Пожары', result: '90%', attempts: 0, status: 'Открыто' });
    const [questions, setQuestions] = useState([{ id: 1, question: 'Номер службы пожарной охраны' }, { id: 2, question: 'Можно ли разжигать костер во дворе?' }, { id: 3, question: 'Можно ли оставлять без присмотра утюг?' }]);
    const [answers, setAnswers] = useState({});
    const [submitted, setSubmitted] = useState(false);
    const [time, setTime] = useState(600); // Время в секундах (10 минут)
    const [timerOn, setTimerOn] = useState(true);
    const intervalRef = useRef(null);
 
    useEffect(() => {
        const handleBlur = () => {
            if(Number(sessionStorage.getItem('alert')) == 0){
                alert("Ваш тест завершён")
                let alertt = Number(sessionStorage.getItem('alert'));
                sessionStorage.setItem('alert', alertt-1)
                handleSubmit()
            }
            else if(Number(sessionStorage.getItem('alert')) > 0){
                let alertt = Number(sessionStorage.getItem('alert'));
                sessionStorage.setItem('alert', alertt-1)
                alert("Вы переключились со страницы, у вас осталось 1 предупреждение и тест закроется")
            }
            
        };

        window.addEventListener('blur', handleBlur);

        return () => {
        window.removeEventListener('blur', handleBlur);
        };
    }, []);

    useEffect(() => {
        const fetchQuestions = async () => {
            try {
                const response = await fetch('https://localhost:8080/briefing/questions/1');
                if (!response.ok) {
                    throw new Error('Failed to fetch questions');
                }
                const questionsData = await response.json();
                setQuestions(questionsData);
            } catch (error) {
                console.error('Error fetching questions:', error);
            }
        };

        fetchQuestions();

        if (timerOn) {
            intervalRef.current = setInterval(() => {
                setTime(prevTime => prevTime - 1);
            }, 1000);
        }

        return () => clearInterval(intervalRef.current);
    }, []);

    useEffect(() => {
        if (time === 0) {
            handleSubmit();
        }
    }, [time]);

    const handleAnswerChange = (id, event) => {
        const newAnswers = { ...answers };
        newAnswers[id] = event.target.value;
        setAnswers(newAnswers);
        if (!timerOn) {
            setTimerOn(true);
        }
    };

    const handleSubmit = async () => {
        try {
            const response = await fetch('https://localhost:8080/briefing/answerDetails', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(answers),
            });
            if (!response.ok) {
                throw new Error('Failed to submit answers');
            }
            setSubmitted(true);
            
        } catch (error) {
            console.error('Error submitting answers:', error);
        } finally {
            setTimerOn(false);
        }
        window.location.href = "/student/briefing/result";
    };

    const formatTime = (time) => {
        const minutes = Math.floor(time / 60);
        const seconds = time % 60;
        return `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
    };

    return (
        <>
            <div className="header_pr">
                <p className="title_pr">{theme.title} </p>
                <hr className="line" />
            </div>
            <div className="testSt">
            <p className="timer">До окончания {formatTime(time)}</p>
                {questions.map((item, index) => (
                    <div key={item.id}>
                        <p>{item.id}. {item.question}</p>
                        <input
                            className="testAnswer"
                            type="text"
                            value={answers[item.id] || ''}
                            onChange={(event) => handleAnswerChange(item.id, event)}
                        />
                    </div>
                ))}
                <button className="finishButton" onClick={handleSubmit}>Завершить</button>
            </div>
        </>
    );
}

export default TestSt;
