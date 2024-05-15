import { useState, useEffect } from "react";

function NewsT(){
    const [listBr, setListBr] = useState([]);
    const [textInput, setTextInput] = useState('');
    const [selectedProfile, setSelectedProfile] = useState('');
    
    useEffect(() => {
        fetch("http://localhost:8080/briefing/newsByTeacher/"+sessionStorage.getItem('idUser'), {
            mode: 'cors',
            method: 'GET',
        })
        .then(res => res.json())
        .then(data => setListBr(data))
        .catch((e)=> console.log(e.message))
    }, [])

    const elBr = listBr.map((item)=> (
        <div className="elBriefing" key={item.id}>
            <p className="title">{item.title}<span>{item.date}</span></p>
            <p>{item.text}</p>
        </div>
    ));

    // Обработчик изменения значения поля ввода текста
    const handleTextChange = (event) => {
        setTextInput(event.target.value);
    };

    // Обработчик изменения выбранного профиля
    const handleProfileChange = (event) => {
        setSelectedProfile(event.target.value);
    };

    // Обработчик нажатия на кнопку "Добавить"
    const handleAdd = () => {
        // Отправка данных на сервер или другие необходимые действия
        console.log('Добавлен текст:', textInput);
        console.log('Выбранный профиль:', selectedProfile);
        // Очистка поля ввода и сброс выбранного профиля после добавления
        setTextInput('');
        setSelectedProfile('');

        const date = new Date();

        // Год с ведущим нулем
        const year = date.getFullYear().toString().padStart(2, '0');

        // Месяц с ведущим нулем
        const month = (date.getMonth() + 1).toString().padStart(2, '0');

        // День с ведущим нулем
        const day = date.getDate().toString().padStart(2, '0');

        // Часы с ведущим нулем
        const hours = date.getHours().toString().padStart(2, '0');

        // Минуты с ведущим нулем
        const minutes = date.getMinutes().toString().padStart(2, '0');

        // Секунды с ведущим нулем
        const seconds = date.getSeconds().toString().padStart(2, '0');

        // Полная дата в формате ISO 8601
        const isoDate = `${year}-${month}-${day}T${hours}:${minutes}:${seconds}`;

        fetch("http://localhost:8080/briefing/addNew", {
                method: "POST",
                headers: {"Content-Type":"application/json"},
                body: JSON.stringify({text: textInput,id_teacher: sessionStorage.getItem('idUser'), id_profile: 1, date_start: isoDate})
            })
            .then(()=>{console.log("Add Briefing")})
            .catch((e)=> console.log(e.message))

        window.location.reload();
    };

    return(
        <div className="news">
            <div className="listBriefing">
                {elBr}
            </div>
            <div className="add-section">
                <textarea
                    className="elInput"
                    value={textInput}
                    onChange={handleTextChange}
                    placeholder="Введите текст новости"
                />
                <div className="newsProfil">
                <select className="subjectInput" value={selectedProfile} onChange={handleProfileChange}>
                    <option value="">Выберите профиль</option>
                    <option value="ИФСТ">ИФСТ</option>
                    <option value="ПИНФ">ПИНФ</option>
                    <option value="ПИНЖ">ПИНЖ</option>
                </select>
                <button className="finishButton" onClick={handleAdd}>Добавить</button>
                </div>
            </div>
        </div>
    );
}

export default NewsT;
