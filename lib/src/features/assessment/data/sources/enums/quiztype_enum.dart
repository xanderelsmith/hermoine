enum QuizType {
  multichoice('multichoice'),

  draganddrop('draganddrop'),

  shortTextAnswer('shortTextAnswer');

  const QuizType(this.valueName);

  final String valueName;
}

//  truefalse, fillintheblank,
//   sequence, selectfromList,  selectfromlist,

