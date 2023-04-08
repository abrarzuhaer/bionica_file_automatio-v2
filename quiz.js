import React, { useState } from 'react';

function Quiz() {
  const questions = [
    {
      id: 1,
      question: 'What is the capital of France?',
      options: ['London', 'Paris', 'Madrid'],
      answer: 'Paris'
    },
    {
      id: 2,
      question: 'What is the largest continent in the world?',
      options: ['Europe', 'Africa', 'Asia'],
      answer: 'Asia'
    },
    {
      id: 3,
      question: 'What is the chemical symbol for gold?',
      options: ['Au', 'Ag', 'Cu'],
      answer: 'Au'
    },
    {
      id: 4,
      question: 'What is the largest planet in our solar system?',
      options: ['Saturn', 'Jupiter', 'Neptune'],
      answer: 'Jupiter'
    },
    {
      id: 5,
      question: 'What is the tallest mammal in the world?',
      options: ['Elephant', 'Giraffe', 'Rhinoceros'],
      answer: 'Giraffe'
    },
    {
      id: 6,
      question: 'What is the world\'s largest ocean?',
      options: ['Atlantic', 'Indian', 'Pacific'],
      answer: 'Pacific'
    },
    {
      id: 7,
      question: 'What is the national animal of Australia?',
      options: ['Kangaroo', 'Koala', 'Emu'],
      answer: 'Kangaroo'
    }
  ];

  const [selectedAnswers, setSelectedAnswers] = useState(new Array(questions.length).fill(''));

  const handleAnswerChange = (questionId, answer) => {
    const newSelectedAnswers = [...selectedAnswers];
    newSelectedAnswers[questionId - 1] = answer;
    setSelectedAnswers(newSelectedAnswers);
  }

  const handleSubmit = () => {
    let score = 0;
    questions.forEach((question, index) => {
      if (selectedAnswers[index] === question.answer) {
        score++;
      }
    });
    alert(`Your score is ${score} out of ${questions.length}`);
  }

  return (
    <div>
      <h1>Quiz</h1>
      {questions.map((question) => (
        <div key={question.id}>
          <h3>{question.question}</h3>
          {question.options.map((option) => (
            <div key={option}>
              <label>
                <input
                  type="radio"
                  name={`question${question.id}`}
                  value={option}
                  checked={selectedAnswers[question.id - 1] === option}
                  onChange={() => handleAnswerChange(question.id, option)}
                />
                {option}
              </label>
            </div>
          ))}
        </div>
      ))}
      <button onClick={handleSubmit}>Submit</button>
    </div>
  );
}

export default Quiz;


