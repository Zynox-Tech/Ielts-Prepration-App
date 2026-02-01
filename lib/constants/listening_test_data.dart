import 'package:ielts/models/listening_test_model.dart';

class ListeningTestData {
  static final List<ListeningTestModel> tests = [
    ListeningTestModel(
      id: 'listening_1',
      difficulty: 'Easy',
      title: 'Conversation in a University Office',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/01j1JoOBFtl8k5Ny9tRTfQ/1ca47ffd441a1992a897a01d1b85ccf1/Audio_-_Free_practice_test_-_Listening_-_Matching_-_Sample_1.mp3',
      duration: 180,
      questions: [
        QuestionModel(
          question:
              'What does Jack tell his tutor about the "Media Studies" course?',
          options: [
            'A. He\'ll definitely do it.',
            'B. He may or may not do it.',
            'C. He won\'t do it.',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'What does Jack tell his tutor about the "Women and Power" course?',
          options: [
            'A. He\'ll definitely do it.',
            'B. He may or may not do it.',
            'C. He won\'t do it.',
          ],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'What does Jack tell his tutor about the "Culture and Society" course?',
          options: [
            'A. He\'ll definitely do it.',
            'B. He may or may not do it.',
            'C. He won\'t do it.',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'What does Jack tell his tutor about the "Identity and Popular Culture" course?',
          options: [
            'A. He\'ll definitely do it.',
            'B. He may or may not do it.',
            'C. He won\'t do it.',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'What does Jack tell his tutor about the "Introduction to Cultural Theory" course?',
          options: [
            'A. He\'ll definitely do it.',
            'B. He may or may not do it.',
            'C. He won\'t do it.',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_2',
      difficulty: 'Easy',
      title: 'Hotel Information',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/6nGVxGcaw4NxE8pejWcm2/f6e4a9b8019259a33701bf41aa2009d6/Audio_-_Free_practice_test_-_Listening_-_Matching_-_Sample_2.mp3',
      duration: 160,
      questions: [
        QuestionModel(
          question: '1. Which hotel is in a rural area?',
          options: [
            'A. The Bridge Hotel',
            'B. Carlton House',
            'C. The Imperial',
            'D. The Majestic',
            'E. The Royal Oak',
          ],
          correctAnswerIndex: 4,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: '2. Which hotel only opened recently?',
          options: [
            'A. The Bridge Hotel',
            'B. Carlton House',
            'C. The Imperial',
            'D. The Majestic',
            'E. The Royal Oak',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: '3. Which hotel offers facilities for business functions?',
          options: [
            'A. The Bridge Hotel',
            'B. Carlton House',
            'C. The Imperial',
            'D. The Majestic',
            'E. The Royal Oak',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: '4. Which hotel has an indoor swimming pool?',
          options: [
            'A. The Bridge Hotel',
            'B. Carlton House',
            'C. The Imperial',
            'D. The Majestic',
            'E. The Royal Oak',
          ],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_3',
      difficulty: 'Easy',
      title: 'Library Information',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/3cB4ifvDTH8J8I5h7SCGQ8/7f6eeefce8ab4ff4fa4c7ce081ce8402/Audio_-_Free_practice_test_-_Listening_-_Plan__map__diagram__labelling.mp3',
      duration: 160,
      questions: [
        QuestionModel(
          question:
              '11. Which area is located in the first room on the left, opposite the Librarian\'s desk?',
          options: [
            'A. Art collection',
            'B. Children\'s books',
            'C. Computers',
            'D. Local history collection',
            'E. Meeting room',
            'F. Multimedia',
            'G. Periodicals',
            'H. Reference books',
            'I. Tourist information',
          ],
          correctAnswerIndex: 7,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              '12. Which area is located just beyond the Librarian\'s desk on the right?',
          options: [
            'A. Art collection',
            'B. Children\'s books',
            'C. Computers',
            'D. Local history collection',
            'E. Meeting room',
            'F. Multimedia',
            'G. Periodicals',
            'H. Reference books',
            'I. Tourist information',
          ],
          correctAnswerIndex: 6,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              '13. Which collection is located on the shelves on the far wall of the main Library Area?',
          options: [
            'A. Art collection',
            'B. Children\'s books',
            'C. Computers',
            'D. Local history collection',
            'E. Meeting room',
            'F. Multimedia',
            'G. Periodicals',
            'H. Reference books',
            'I. Tourist information',
          ],
          correctAnswerIndex: 3,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: '14. Which area is located next door to the Seminar Room?',
          options: [
            'A. Art collection',
            'B. Children\'s books',
            'C. Computers',
            'D. Local history collection',
            'E. Meeting room',
            'F. Multimedia',
            'G. Periodicals',
            'H. Reference books',
            'I. Tourist information',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              '15. Which collection is located in the large room to the right of the Library Area?',
          options: [
            'A. Art collection',
            'B. Children\'s books',
            'C. Computers',
            'D. Local history collection',
            'E. Meeting room',
            'F. Multimedia',
            'G. Periodicals',
            'H. Reference books',
            'I. Tourist information',
          ],
          correctAnswerIndex: 5,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_4',
      difficulty: 'Easy',
      title: 'Social Contact',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3',
      duration: 92,
      questions: [
        QuestionModel(
          question:
              '11. What is one factor that can make social contact in a foreign country difficult?',
          options: [
            'The language',
            'The accommodation',
            'The distance',
            'The lack of money',
          ],
          correctAnswerIndex: 0,
          questionType: 'short_answer_factor_1',
        ),
        QuestionModel(
          question:
              '12. What is the second factor that can make social contact in a foreign country difficult?',
          options: [
            'The language',
            'The customs',
            'The distance',
            'The lack of money',
          ],
          correctAnswerIndex: 1,
          questionType: 'short_answer_factor_2',
        ),
        QuestionModel(
          question:
              '13. Besides theatre, what is another type of community group the speaker gives as an example?',
          options: [
            'Drama groups',
            'Sports clubs',
            'Music groups',
            'Gardening clubs',
          ],
          correctAnswerIndex: 2,
          questionType: 'short_answer_group_1',
        ),
        QuestionModel(
          question:
              '14. What is a third type of community group the speaker gives as an example?',
          options: [
            'Travel groups',
            'Art classes',
            'Local history (groups)',
            'Cooking clubs',
          ],
          correctAnswerIndex: 2,
          questionType: 'short_answer_group_2',
        ),
        QuestionModel(
          question:
              '15. What is one place where information about community activities can be found?',
          options: [
            'The local newspaper',
            'The town hall',
            'The church',
            'The police station',
          ],
          correctAnswerIndex: 1,
          questionType: 'short_answer_place_1',
        ),
        QuestionModel(
          question:
              '16. What is another place where information about community activities can be found?',
          options: [
            'The school',
            'The public library',
            'The town hall',
            'The internet',
          ],
          correctAnswerIndex: 1,
          questionType: 'short_answer_place_2',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_5',
      difficulty: 'Easy',
      title: 'University Orientation',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3', // Placeholder
      duration: 150,
      questions: [
        QuestionModel(
          question: 'Where is the orientation meeting held?',
          options: ['Main Hall', 'Student Center', 'Library', 'Gymnasium'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'What time does the campus tour start?',
          options: ['9:00 AM', '10:00 AM', '11:00 AM', '1:00 PM'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Students must register for classes by:',
          options: ['Friday', 'Monday', 'Wednesday', 'Tuesday'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Where can students get their ID cards?',
          options: [
            'Administration Building',
            'Security Office',
            'Library',
            'Student Union',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_6',
      difficulty: 'Medium',
      title: 'Museum Tour Guide',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3', // Placeholder
      duration: 140,
      questions: [
        QuestionModel(
          question: 'The museum was founded in which year?',
          options: ['1850', '1890', '1905', '1920'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Which exhibit is currently closed for renovation?',
          options: [
            'Ancient Egypt',
            'Dinosaur Hall',
            'Modern Art',
            'Space Exploration',
          ],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Visitors are not allowed to take photos in:',
          options: [
            'The lobby',
            'The cafe',
            'The special exhibition',
            'The garden',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The museum closes at:',
          options: ['4:00 PM', '5:00 PM', '6:00 PM', '8:00 PM'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_7',
      difficulty: 'Medium',
      title: 'Travel Booking Enquiry',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3', // Placeholder
      duration: 130,
      questions: [
        QuestionModel(
          question: 'The customer wants to travel to:',
          options: ['Paris', 'London', 'Rome', 'Berlin'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'How many people are travelling?',
          options: ['1', '2', '3', '4'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The preferred mode of transport is:',
          options: ['Plane', 'Train', 'Bus', 'Car'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The budget per person is:',
          options: ['\$500', '\$800', '\$1000', '\$1500'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_8',
      difficulty: 'Medium',
      title: 'Lecture on Bees',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3', // Placeholder
      duration: 170,
      questions: [
        QuestionModel(
          question: 'What is the main topic of the lecture?',
          options: [
            'Bee anatomy',
            'Honey production',
            'Bee decline',
            'Types of hives',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Which factor is NOT mentioned as a cause of decline?',
          options: [
            'Pesticides',
            'Climate change',
            'Habitat loss',
            'Overpopulation',
          ],
          correctAnswerIndex: 3,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Bees are responsible for pollinating what percentage of crops?',
          options: ['30%', '50%', '70%', '90%'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The lecturer suggests planting:',
          options: ['Trees', 'Wildflowers', 'Vegetables', 'Grass'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_9',
      difficulty: 'Medium',
      title: 'History of Architecture',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3', // Placeholder
      duration: 160,
      questions: [
        QuestionModel(
          question: 'Gothic architecture originated in:',
          options: ['Italy', 'France', 'Germany', 'England'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'A key feature of Gothic architecture is:',
          options: ['Round arches', 'Pointed arches', 'Domes', 'Thick walls'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The lecture mentions which famous cathedral?',
          options: [
            'St. Paul\'s',
            'Notre Dame',
            'St. Peter\'s',
            'Westminster Abbey',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Gothic architecture was followed by:',
          options: ['Romanesque', 'Baroque', 'Renaissance', 'Modernism'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_10',
      difficulty: 'Medium',
      title: 'Job Interview',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3', // Placeholder
      duration: 120,
      questions: [
        QuestionModel(
          question: 'The applicant is applying for the position of:',
          options: [
            'Manager',
            'Assistant',
            'Sales Representative',
            'Accountant',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'How many years of experience does the applicant have?',
          options: ['1 year', '3 years', '5 years', '10 years'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The applicant mentions a strength in:',
          options: ['Communication', 'Coding', 'Design', 'Accounting'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'When can the applicant start?',
          options: ['Immediately', 'Next week', 'In two weeks', 'Next month'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_11',
      difficulty: 'Hard',
      title: 'Cooking Class Registration',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3', // Placeholder
      duration: 110,
      questions: [
        QuestionModel(
          question: 'The class starts at:',
          options: ['5:00 PM', '6:00 PM', '6:30 PM', '7:00 PM'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The cost of the course includes:',
          options: ['Apron', 'Ingredients', 'Knife set', 'Recipe book'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The first lesson covers:',
          options: ['Baking', 'Knife skills', 'Sauces', 'Soups'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Students need to bring:',
          options: ['Containers', 'Knives', 'Towels', 'Notebooks'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_12',
      difficulty: 'Hard',
      title: 'Library Tour',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3', // Placeholder
      duration: 140,
      questions: [
        QuestionModel(
          question: 'The library is open until:',
          options: ['8:00 PM', '9:00 PM', '10:00 PM', 'Midnight'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Where are the photocopiers located?',
          options: ['Ground floor', 'First floor', 'Second floor', 'Basement'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'How many books can undergraduates borrow?',
          options: ['5', '10', '15', '20'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Quiet study areas are on the:',
          options: ['Ground floor', 'First floor', 'Top floor', 'Mezzanine'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_13',
      difficulty: 'Hard',
      title: 'Sports Centre Membership',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3', // Placeholder
      duration: 130,
      questions: [
        QuestionModel(
          question: 'The Gold membership includes access to:',
          options: [
            'Gym only',
            'Gym and pool',
            'All facilities',
            'Classes only',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The joining fee is:',
          options: ['\$20', '\$30', '\$40', '\$50'],
          correctAnswerIndex: 3,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The centre opens on weekends at:',
          options: ['6:00 AM', '7:00 AM', '8:00 AM', '9:00 AM'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Members get a discount at the:',
          options: ['Cafe', 'Pro shop', 'Spa', 'Parking'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_14',
      difficulty: 'Hard',
      title: 'Geography Lecture',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3', // Placeholder
      duration: 160,
      questions: [
        QuestionModel(
          question: 'The lecture focuses on which region?',
          options: ['The Amazon', 'The Sahara', 'The Arctic', 'The Himalayas'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The main threat discussed is:',
          options: ['Deforestation', 'Pollution', 'Tourism', 'Mining'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'The region is home to what percentage of the world\'s species?',
          options: ['5%', '10%', '20%', '50%'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The lecturer mentions the importance of:',
          options: ['Oil reserves', 'Medicinal plants', 'Timber', 'Gold'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ListeningTestModel(
      id: 'listening_15',
      difficulty: 'Hard',
      title: 'Art Gallery Guide',
      audioUrl:
          'https://assets.ctfassets.net/unrdeg6se4ke/1hRNidL57mr2Ywe6rneJP1/b0c82983fa86586f02f1c5fad5979d3d/Audio_-_Free_practice_test_-_Listening_-_Short_answer_questions_-_Sample_1.mp3', // Placeholder
      duration: 120,
      questions: [
        QuestionModel(
          question: 'The gallery specializes in:',
          options: [
            'Renaissance art',
            'Modern art',
            'Impressionism',
            'Sculpture',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The guided tour lasts for:',
          options: ['30 minutes', '45 minutes', '1 hour', '1.5 hours'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The gift shop is located near the:',
          options: ['Entrance', 'Exit', 'Cafe', 'Restrooms'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Audio guides are available in how many languages?',
          options: ['3', '5', '8', '10'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
      ],
    ),
  ];
}
