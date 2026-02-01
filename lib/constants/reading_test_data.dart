import 'package:ielts/models/reading_test_model.dart';

class ReadingTestData {
  static final List<ReadingTestModel> tests = [
    ReadingTestModel(
      id: 'reading_1',
      difficulty: 'Easy',
      title: 'The Impact of Artificial Intelligence on Modern Society',
      passage: '''
Artificial Intelligence (AI) has emerged as one of the most transformative technologies of the 21st century, fundamentally reshaping how we live, work, and interact with the world around us. From virtual assistants that manage our daily schedules to sophisticated algorithms that drive autonomous vehicles, AI has permeated nearly every aspect of modern life. The technology, which enables machines to perform tasks that typically require human intelligence, has evolved rapidly over the past decade, moving from research laboratories into practical applications that affect billions of people worldwide.

The roots of AI can be traced back to the 1950s when computer scientist Alan Turing posed the question, "Can machines think?" This philosophical inquiry led to decades of research and development, culminating in today's advanced machine learning systems and neural networks. Modern AI systems can process vast amounts of data, recognize patterns, make predictions, and even engage in creative tasks such as composing music or generating art. The technology relies on sophisticated algorithms that learn from experience, improving their performance over time without explicit programming for every possible scenario.

In the healthcare sector, AI has demonstrated remarkable potential to revolutionize patient care and medical research. Machine learning algorithms can analyze medical images with accuracy rivaling that of experienced radiologists, detecting early signs of diseases such as cancer that might be missed by the human eye. AI-powered diagnostic tools can process patient data, medical histories, and genetic information to identify potential health risks and recommend personalized treatment plans. Furthermore, AI is accelerating drug discovery by analyzing complex molecular structures and predicting which compounds are most likely to be effective against specific diseases, potentially reducing the time and cost of bringing new medications to market.

The business world has eagerly embraced AI to enhance efficiency and drive innovation. Customer service has been transformed through AI-powered chatbots that can handle routine inquiries 24/7, freeing human employees to focus on more complex issues requiring empathy and creative problem-solving. In finance, AI algorithms analyze market trends, detect fraudulent transactions, and provide investment recommendations. Manufacturing facilities use AI-driven robots and predictive maintenance systems to optimize production processes and reduce downtime. Retail companies employ AI to personalize shopping experiences, manage inventory, and forecast consumer demand with unprecedented accuracy.

However, the rapid advancement of AI also raises significant ethical and societal concerns. Privacy advocates worry about the extensive data collection required to train AI systems and the potential for this information to be misused. There are legitimate concerns about algorithmic bias, as AI systems trained on historical data may perpetuate or even amplify existing societal inequalities. The prospect of widespread job displacement due to automation has sparked intense debate about the future of work and the need for social safety nets and retraining programs. Questions about accountability arise when AI systems make decisions that affect people's lives – who is responsible when an autonomous vehicle causes an accident or when a hiring algorithm discriminates?

The development of AI governance frameworks and regulations has struggled to keep pace with technological advancement. Different countries and regions have adopted varying approaches to AI regulation, from the European Union's emphasis on transparency and human rights to more permissive frameworks in other jurisdictions. There is ongoing discussion about the need for international cooperation to establish ethical guidelines and standards for AI development and deployment. Many experts advocate for the principle of "explainable AI," where systems can provide clear reasoning for their decisions, particularly in sensitive applications such as healthcare and criminal justice.

Looking toward the future, AI is poised to play an even more central role in addressing global challenges. Climate scientists use AI to model complex environmental systems and develop more accurate climate predictions. AI-powered systems optimize energy consumption in buildings and cities, contributing to sustainability efforts. In agriculture, AI helps farmers maximize crop yields while minimizing resource use through precision farming techniques. Educational technology powered by AI offers personalized learning experiences tailored to individual students' needs and learning styles.

As we navigate this AI-driven transformation of society, it is crucial to approach the technology with both optimism and critical awareness. While AI offers tremendous potential to solve complex problems and improve quality of life, we must remain vigilant about its limitations and potential risks. The key lies in developing AI systems that augment rather than replace human capabilities, that are designed with ethical considerations at their core, and that benefit society broadly rather than concentrating power and wealth in the hands of a few. The future of AI will be shaped not just by technological innovation but by the choices we make about how to develop, deploy, and govern these powerful tools.
''',
      questions: [
        QuestionModel(
          question:
              'Who first posed the fundamental question about whether machines can think?',
          options: [
            'A researcher',
            'Alan Turing',
            'A philosopher',
            'Not mentioned',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'AI in healthcare can detect diseases that humans might miss.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'AI systems require explicit programming for every possible scenario.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'In which sector does the passage mention AI analyzing medical images?',
          options: ['Business', 'Healthcare', 'Manufacturing', 'Education'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'AI-powered chatbots can handle all customer service issues.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What is a major concern related to AI training data?',
          options: ['Cost', 'Privacy', 'Speed', 'Complexity'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'All countries have adopted the same approach to AI regulation.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'According to the passage, what principle do experts advocate for sensitive applications?',
          options: ['Fast AI', 'Cheap AI', 'Explainable AI', 'Simple AI'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'AI is being used to address climate change challenges.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'The passage mentions AI use in which agricultural practice?',
          options: [
            'Organic farming',
            'Precision farming',
            'Traditional farming',
            'Urban farming',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'AI educational technology provides the same learning experience for all students.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What does the passage suggest about job displacement?',
          options: [
            'It is not a concern',
            'It has sparked debate about retraining programs',
            'It only affects manufacturing',
            'It can be easily solved',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'The European Union emphasizes transparency in AI regulation.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'According to the conclusion, how should AI be developed?',
          options: [
            'To replace human capabilities',
            'To augment human capabilities',
            'To be as complex as possible',
            'To concentrate wealth',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
      ],
    ),

    ReadingTestModel(
      id: 'reading_2',
      difficulty: 'Easy',
      title: 'The Evolution of Urban Transportation Systems',
      passage: '''
Urban transportation has undergone dramatic transformations throughout history, shaped by technological innovation, economic development, and changing social needs. From horse-drawn carriages to electric scooters, each era has introduced new modes of transport that have fundamentally altered how cities function and how people navigate urban spaces. Understanding this evolution provides valuable insights into current challenges and future possibilities for urban mobility.

The industrial revolution marked a pivotal moment in urban transportation history. Steam-powered trains and later electric trams emerged in the 19th century, enabling cities to expand beyond their traditional boundaries. These rail-based systems allowed workers to commute from residential suburbs to factory districts, fundamentally changing urban settlement patterns. The introduction of the London Underground in 1863, the world's first underground railway, set a precedent that would be followed by cities worldwide, creating efficient mass transit networks that could move large numbers of people quickly through congested urban cores.

The 20th century witnessed the rise of automobile dominance in urban planning. Following Henry Ford's introduction of mass production techniques, cars became increasingly affordable to the middle class. Cities began redesigning their infrastructure around automobile traffic, widening streets, building highways, and creating extensive parking facilities. This car-centric approach brought unprecedented personal mobility and freedom but also generated significant problems: traffic congestion, air pollution, and social isolation as communities became disconnected by busy roads and highways.

By the late 20th century, the limitations of automobile-dependent cities became increasingly apparent. Many urban planners began advocating for a return to public transportation and pedestrian-friendly design. Cities like Copenhagen and Amsterdam pioneered bicycle-friendly infrastructure, demonstrating that sustainable urban transportation was both practical and desirable. These examples inspired similar initiatives worldwide, leading to the creation of bike-sharing programs, pedestrian zones, and improved public transit systems.

The 21st century has introduced digital technology as a transformative force in urban mobility. Smartphone applications have revolutionized how people access and use transportation services. Ride-sharing platforms connect passengers with drivers, providing flexible alternatives to traditional taxis. Real-time information systems allow commuters to track buses and trains, optimizing their journeys and reducing waiting times. Multi-modal transportation apps integrate various transit options, enabling users to plan complex journeys combining buses, trains, bikes, and walking routes.

Electric vehicles and autonomous driving technology represent the latest frontier in urban transportation innovation. Electric cars offer the promise of reducing greenhouse gas emissions and improving air quality in cities. Major automotive manufacturers have committed to transitioning their fleets to electric power, while new companies focused exclusively on electric vehicles have emerged as significant market players. Autonomous vehicles, though still in development, could potentially revolutionize urban transportation by improving safety, reducing parking needs, and providing mobility solutions for those unable to drive.

However, technological solutions alone cannot address all urban transportation challenges. Social equity remains a critical concern, as new transportation technologies and services often remain inaccessible to low-income communities. The "digital divide" means that smartphone-dependent services may exclude elderly residents or those without reliable internet access. Urban planners must ensure that transportation systems serve all residents equitably, not just those with resources to access the latest technologies.

Environmental considerations have become increasingly central to transportation planning. Cities worldwide are setting ambitious targets to reduce carbon emissions and combat climate change. Many European cities have announced plans to ban internal combustion engine vehicles from their centers by 2030. Transportation authorities are investing heavily in electric public transit, including electric buses and trains. Green infrastructure initiatives integrate transportation with urban ecology, creating tree-lined bike paths and transit corridors that enhance both mobility and environmental quality.

The COVID-19 pandemic has prompted a fundamental reassessment of urban transportation. Temporary measures to create more space for pedestrians and cyclists became permanent features in many cities. Remote work reduced commuting demand, leading to questions about the future role of mass transit. Concerns about disease transmission in crowded vehicles accelerated interest in personal mobility devices and outdoor transportation modes.

Looking ahead, successful urban transportation systems will likely embrace flexibility and diversity. Rather than relying on a single dominant mode, future cities may offer a rich ecosystem of transportation options tailored to different needs and circumstances. Integration between modes will be crucial, with seamless transfers between buses, trains, bikes, and emerging micro-mobility devices. Data analytics and artificial intelligence will optimize traffic flow and service provision in real-time. Sustainable, equitable, and efficient urban transportation remains one of the great challenges and opportunities of our time.
''',
      questions: [
        QuestionModel(
          question: 'The first underground railway system was built in:',
          options: ['Paris', 'New York', 'London', 'Berlin'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Steam-powered trains enabled cities to expand beyond traditional boundaries.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Henry Ford invented the automobile.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 2,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Which cities are mentioned as pioneers in bicycle-friendly infrastructure?',
          options: [
            'Paris and London',
            'Copenhagen and Amsterdam',
            'New York and Berlin',
            'Tokyo and Singapore',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Smartphone applications have changed how people access transportation services.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'All major automotive manufacturers have already completed their transition to electric vehicles.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'What is mentioned as a barrier to accessing smartphone-dependent transportation services?',
          options: ['Cost', 'The digital divide', 'Language', 'Education'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'When do many European cities plan to ban combustion engine vehicles from city centers?',
          options: ['2025', '2030', '2035', '2040'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'The COVID-19 pandemic had no impact on urban transportation planning.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Autonomous vehicles are currently widely deployed in cities.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'According to the passage, what will be crucial for future urban transportation?',
          options: [
            'Relying on one transportation mode',
            'Integration between different modes',
            'Eliminating public transit',
            'Banning bicycles',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Green infrastructure initiatives mentioned in the passage include:',
          options: [
            'Underground tunnels',
            'Highway expansion',
            'Tree-lined bike paths',
            'Parking garages',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Remote work during the pandemic increased commuting demand.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'What technology is mentioned for optimizing traffic flow in the future?',
          options: [
            'Solar panels',
            'Data analytics and AI',
            'Wind turbines',
            'Nuclear power',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ReadingTestModel(
      id: 'reading_3',
      difficulty: 'Easy',
      title: 'The History of Coffee',
      passage: '''
The story of coffee begins in the highlands of Ethiopia, where legend has it that a goat herder named Kaldi first discovered the potential of these beloved beans. He noticed that his goats became unusually energetic after eating berries from a certain tree, so much so that they did not want to sleep at night. Kaldi reported his findings to the abbot of the local monastery, who made a drink with the berries and found that it kept him alert through the long hours of evening prayer. The abbot shared his discovery with the other monks at the monastery, and knowledge of the energizing berries began to spread.

As word moved east and coffee reached the Arabian peninsula, it began a journey which would bring these beans across the globe. By the 15th century, coffee was being grown in the Yemeni district of Arabia and by the 16th century, it was known in Persia, Egypt, Syria, and Turkey. Coffee was not only enjoyed in homes, but also in the many public coffee houses — called qahveh khaneh — which began to appear in cities across the Near East. The popularity of the coffee houses was unequaled and people frequented them for all kinds of social activity. Not only did the patrons drink coffee and engage in conversation, but they also listened to music, watched performers, played chess and kept current on the news.

European travelers to the Near East brought back stories of an unusual dark black beverage. By the 17th century, coffee had made its way to Europe and was becoming popular across the continent. Some people reacted to this new beverage with suspicion or fear, calling it the "bitter invention of Satan." The local clergy condemned coffee when it came to Venice in 1615. The controversy was so great that Pope Clement VIII was asked to intervene. He decided to taste the beverage for himself before making a decision, and found the drink so satisfying that he gave it papal approval.

Despite such controversy, coffee houses were quickly becoming centers of social activity and communication in the major cities of England, Austria, France, Germany and Holland. In England "penny universities" sprang up, so called because for the price of a penny one could purchase a cup of coffee and engage in stimulating conversation. By the mid-17th century, there were over 300 coffee houses in London, many of which attracted like-minded patrons, including merchants, shippers, brokers and artists.

Many businesses grew out of these specialized coffee houses. Lloyd's of London, for example, came into existence at the Edward Lloyd's Coffee House. In the mid-1600s, coffee was brought to New Amsterdam, later called New York by the British. Though coffee houses rapidly began to appear, tea continued to be the favored drink in the New World until 1773, when the colonists revolted against a heavy tax on tea imposed by King George III. The revolt, known as the Boston Tea Party, would forever change the American drinking preference to coffee.
''',
      questions: [
        QuestionModel(
          question: 'Where did coffee originate according to legend?',
          options: ['Yemen', 'Ethiopia', 'Persia', 'Egypt'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Who was Kaldi?',
          options: ['A monk', 'A goat herder', 'A merchant', 'A king'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Coffee houses in the Near East were used only for drinking coffee.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'When did coffee reach Europe?',
          options: [
            '15th century',
            '16th century',
            '17th century',
            '18th century',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Pope Clement VIII banned coffee.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What were "penny universities"?',
          options: ['Schools', 'Coffee houses', 'Libraries', 'Churches'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Lloyd\'s of London started in a coffee house.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'What event changed American drinking preference to coffee?',
          options: [
            'The Civil War',
            'The Boston Tea Party',
            'The Industrial Revolution',
            'The discovery of Brazil',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Coffee was initially welcomed by everyone in Europe without suspicion.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'The passage mentions coffee being grown in which district of Arabia?',
          options: ['Mecca', 'Yemeni', 'Medina', 'Riyadh'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'In the Near East, people played chess in coffee houses.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'New York was originally called:',
          options: ['New London', 'New Amsterdam', 'New Paris', 'New England'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'King George III imposed a heavy tax on coffee.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'How many coffee houses were in London by the mid-17th century?',
          options: ['Over 100', 'Over 200', 'Over 300', 'Over 400'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ReadingTestModel(
      id: 'reading_4',
      difficulty: 'Easy',
      title: 'Renewable Energy Sources',
      passage: '''
Renewable energy is energy that is collected from renewable resources, which are naturally replenished on a human timescale, such as sunlight, wind, rain, tides, waves, and geothermal heat. Renewable energy often provides energy in four important areas: electricity generation, air and water heating/cooling, transportation, and rural (off-grid) energy services.

Based on REN21's 2017 report, renewables contributed 19.3% to humans' global energy consumption and 24.5% to their generation of electricity in 2015 and 2016, respectively. This energy consumption is divided as 8.9% coming from traditional biomass, 4.2% as heat energy (modern biomass, geothermal and solar heat), 3.9% hydro electricity and 2.2% is electricity from wind, solar, geothermal, and biomass. Worldwide investments in renewable technologies amounted to more than US\$286 billion in 2015, with countries like China and the United States heavily investing in wind, hydro, solar and biofuels.

Solar energy, radiant light and heat from the sun, is harnessed using a range of ever-evolving technologies such as solar heating, photovoltaics, concentrated solar power, concentrator photovoltaics, solar architecture and artificial photosynthesis. It is an important source of renewable energy and its technologies are broadly characterized as either passive solar or active solar depending on how they capture and distribute solar energy or convert it into solar power. Active solar techniques include the use of photovoltaic systems, concentrated solar power and solar water heating to harness the energy. Passive solar techniques include orienting a building to the Sun, selecting materials with favorable thermal mass or light-dispersing properties, and designing spaces that naturally circulate air.

Wind power is the use of air flow through wind turbines to mechanically power generators for electric power. Wind farms consist of many individual wind turbines, which are connected to the electric power transmission network. Onshore wind is an inexpensive source of electric power, competitive with or in many places cheaper than coal or gas plants. Offshore wind is steadier and stronger than on land and offshore farms have less visual impact, but construction and maintenance costs are considerably higher. Small onshore wind farms provide electricity to isolated locations.

Hydroelectric energy is a form of energy that harnesses the power of water in motion—such as water flowing over a waterfall—to generate electricity. People have used this force for millennia. Over two thousand years ago, people in Greece used flowing water to turn the wheel of their mill to grind wheat into flour. Today, hydropower is the most widely used renewable source of electricity.

Geothermal energy is the heat from the Earth. It's clean and sustainable. Resources of geothermal energy range from the shallow ground to hot water and hot rock found a few miles beneath the Earth's surface, and down even deeper to the extremely high temperatures of molten rock called magma.

While renewable energy projects are large-scale, renewable technologies are also suited to rural and remote areas and developing countries, where energy is often crucial in human development. As most of renewable energy technologies provide electricity, renewable energy deployment is often applied in conjunction with further electrification, which has several benefits: electricity can convert to heat, can be converted into mechanical energy with high efficiency, and is clean at the point of consumption.
''',
      questions: [
        QuestionModel(
          question:
              'What percentage of global energy consumption came from renewables in 2015 according to REN21?',
          options: ['19.3%', '24.5%', '8.9%', '4.2%'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Solar energy technologies are characterized as either passive or active.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Which country is NOT mentioned as heavily investing in renewable technologies?',
          options: ['China', 'United States', 'Germany', 'None of the above'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Offshore wind farms are cheaper to construct than onshore ones.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'What is the most widely used renewable source of electricity?',
          options: ['Solar', 'Wind', 'Hydropower', 'Geothermal'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Geothermal energy comes from the sun.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Passive solar techniques include using photovoltaic systems.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Renewable energy is not suitable for rural areas.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'How long have people used water power?',
          options: [
            'Since 2015',
            'For a few decades',
            'For millennia',
            'Since the industrial revolution',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Magma is mentioned in relation to which energy source?',
          options: ['Solar', 'Wind', 'Hydro', 'Geothermal'],
          correctAnswerIndex: 3,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Onshore wind is more expensive than coal in all locations.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Renewable energy provides energy for transportation.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'What was the total investment in renewable technologies in 2015?',
          options: [
            'US\$100 billion',
            'US\$286 billion',
            'US\$500 billion',
            'US\$1 trillion',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Electricity is clean at the point of consumption.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
      ],
    ),
    ReadingTestModel(
      id: 'reading_5',
      difficulty: 'Medium',
      title: 'The Psychology of Color',
      passage: '''
Color psychology is the study of how colors affect human behavior, mood, and physiological processes. While perceptions of color are somewhat subjective, there are some color effects that have universal meaning. Colors in the red area of the color spectrum are known as warm colors and include red, orange, and yellow. These warm colors evoke emotions ranging from feelings of warmth and comfort to feelings of anger and hostility. Colors on the blue side of the spectrum are known as cool colors and include blue, purple, and green. These colors are often described as calm, but can also call to mind feelings of sadness or indifference.

Color psychology is widely used in marketing and branding. Many companies use color to send a specific message to consumers. For example, red is often used to create a sense of urgency, which is why it is frequently used in clearance sales. It is also known to stimulate appetite, making it a popular choice for fast-food chains. Blue, on the other hand, is associated with reliability and trust, which is why it is commonly used by banks and financial institutions. Green is often used to represent health, tranquility, and nature, making it a favorite for eco-friendly brands.

Cultural differences also play a significant role in how colors are perceived. In Western cultures, white is often associated with purity and weddings, while in some Eastern cultures, it is the color of mourning. Similarly, red represents good luck and prosperity in China, but can signal danger or debt in Western financial contexts. Understanding these cultural nuances is essential for global marketing campaigns.

Beyond marketing, color psychology is applied in interior design and therapy. Chromotherapy, or light therapy, is an alternative medicine method that uses color and light to treat physical or mental health conditions. For instance, blue light is sometimes used to treat neonatal jaundice, and bright white light is used to treat Seasonal Affective Disorder (SAD). In interior design, cool colors like blue and green are often recommended for bedrooms to promote relaxation, while warm colors like yellow might be used in kitchens or dining areas to stimulate energy and conversation.

Research has also shown that color can impact performance. One study found that exposing students to the color red prior to an exam had a negative impact on their performance. Another study suggested that blue light could improve alertness and performance on tasks requiring sustained attention. However, the field of color psychology is still evolving, and many claims lack rigorous scientific backing. Personal preference, upbringing, and context all interact with color to shape our individual experiences.
''',
      questions: [
        QuestionModel(
          question: 'Warm colors include which of the following?',
          options: [
            'Blue, purple, green',
            'Red, orange, yellow',
            'Black, white, grey',
            'Pink, brown, beige',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Cool colors always evoke feelings of calmness.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Why do fast-food chains often use the color red?',
          options: [
            'It is cheap',
            'It stimulates appetite',
            'It represents nature',
            'It is calming',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Blue is commonly used by which type of institutions?',
          options: [
            'Fast food',
            'Eco-friendly brands',
            'Banks',
            'Clearance sales',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'In Eastern cultures, white is always associated with weddings.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Red represents good luck in which country?',
          options: ['USA', 'China', 'France', 'Germany'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Chromotherapy is a mainstream medical practice.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What is bright white light used to treat?',
          options: ['Jaundice', 'SAD', 'Anxiety', 'Depression'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Cool colors are recommended for kitchens.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Exposing students to red before an exam improved their performance.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Blue light may improve alertness.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Color perception is entirely objective.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Green is associated with:',
          options: ['Danger', 'Health and nature', 'Royalty', 'Mourning'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'The passage suggests that personal preference does not affect color experience.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
      ],
    ),
    ReadingTestModel(
      id: 'reading_6',
      difficulty: 'Medium',
      title: 'The Age of Space Exploration',
      passage: '''
Space exploration is the use of astronomy and space technology to explore outer space. While the study of space is carried out mainly by astronomers with telescopes, the physical exploration of space is conducted both by unmanned robotic space probes and human spaceflight. Space exploration, like its classical form astronomy, is one of the main sources for space science.

The Space Age began on October 4, 1957, with the launch of Sputnik 1 by the Soviet Union. This was the first artificial satellite to orbit the Earth. This event ignited the Space Race between the Soviet Union and the United States. The Soviets achieved several other firsts, including the first human in space, Yuri Gagarin, in 1961. However, the United States achieved the first moon landing with Apollo 11 in 1969, when Neil Armstrong and Buzz Aldrin walked on the lunar surface.

Since the end of the Space Race, space exploration has become more of a cooperative international effort. The International Space Station (ISS), launched in 1998, is a prime example of this collaboration, involving space agencies from the US, Russia, Europe, Japan, and Canada. It serves as a microgravity and space environment research laboratory in which crew members conduct experiments in biology, human biology, physics, astronomy, meteorology, and other fields.

In recent years, the focus has shifted towards the exploration of Mars. NASA's rovers, such as Spirit, Opportunity, Curiosity, and Perseverance, have provided invaluable data about the Red Planet's geology and climate. These missions search for signs of past life and prepare for potential future human missions. The discovery of water ice on Mars has been a significant finding, raising hopes for sustaining human life there.

Another major development is the rise of private space companies like SpaceX, Blue Origin, and Virgin Galactic. These companies are working to lower the cost of space access and develop space tourism. SpaceX, founded by Elon Musk, has successfully developed reusable rockets, drastically reducing the cost of launching payloads into orbit. Their ultimate goal is to enable the colonization of Mars.

Looking to the future, space agencies and private companies are planning missions to return humans to the Moon and eventually send them to Mars. The Artemis program by NASA aims to land "the first woman and the next man" on the Moon by the mid-2020s. Challenges remain, including the long duration of space travel, radiation exposure, and the physiological effects of microgravity on the human body. However, the drive to explore the unknown continues to push the boundaries of human achievement.
''',
      questions: [
        QuestionModel(
          question: 'What event marked the beginning of the Space Age?',
          options: [
            'Apollo 11',
            'Sputnik 1 launch',
            'Yuri Gagarin\'s flight',
            'ISS launch',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Who was the first human in space?',
          options: [
            'Neil Armstrong',
            'Buzz Aldrin',
            'Yuri Gagarin',
            'John Glenn',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'The United States won the race to put the first human in space.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'When was the International Space Station launched?',
          options: ['1969', '1980', '1998', '2000'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Which country is NOT mentioned as a partner in the ISS?',
          options: ['China', 'Canada', 'Japan', 'Russia'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'NASA\'s rovers are exploring Venus.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What significant discovery on Mars is mentioned?',
          options: ['Aliens', 'Water ice', 'Gold', 'Oil'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'SpaceX was founded by Jeff Bezos.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What is the main goal of the Artemis program?',
          options: [
            'To go to Mars directly',
            'To return humans to the Moon',
            'To build a new ISS',
            'To mine asteroids',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Reusable rockets have increased the cost of space launches.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Radiation exposure is a challenge for long-duration space travel.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Private companies are interested in space tourism.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Curiosity is the name of a:',
          options: ['Rocket', 'Rover', 'Satellite', 'Space station'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The passage mentions the physiological effects of:',
          options: [
            'High gravity',
            'Microgravity',
            'Zero gravity',
            'Artificial gravity',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
      ],
    ),
    ReadingTestModel(
      id: 'reading_7',
      difficulty: 'Medium',
      title: 'The Great Barrier Reef',
      passage: '''
The Great Barrier Reef is the world's largest coral reef system, composed of over 2,900 individual reefs and 900 islands stretching for over 2,300 kilometres over an area of approximately 344,400 square kilometres. The reef is located in the Coral Sea, off the coast of Queensland, Australia. The Great Barrier Reef can be seen from outer space and is the world's biggest single structure made by living organisms. This reef structure is composed of and built by billions of tiny organisms, known as coral polyps. It supports a wide diversity of life and was selected as a World Heritage Site in 1981.

The reef is a highly diverse ecosystem, home to thousands of species. It hosts 1,500 species of fish, 411 types of hard coral, one-third of the world's soft corals, 134 species of sharks and rays, six of the world's seven species of threatened marine turtles, and more than 30 species of marine mammals, including the vulnerable dugong. This biodiversity makes it one of the most complex natural systems on Earth.

However, the Great Barrier Reef faces significant environmental threats. Climate change is the greatest threat to the reef. Rising water temperatures cause coral bleaching, a phenomenon where corals expel the algae living in their tissues, causing them to turn completely white. While corals can survive a bleaching event, they are under more stress and are subject to mortality. Mass bleaching events have occurred with increasing frequency in recent years, causing widespread damage.

Other threats include pollution, particularly runoff from farms including pesticides and fertilizers, which can lead to algal blooms that smother coral. Crown-of-thorns starfish outbreaks are another major issue; these starfish feed on coral polyps and can devastate large areas of the reef. Overfishing and shipping accidents also pose risks to this fragile ecosystem.

Tourism is an important economic activity for the region, generating over \$6 billion annually and supporting thousands of jobs. However, it must be managed carefully to ensure it is sustainable. The Great Barrier Reef Marine Park Authority manages the reef, implementing zoning plans to protect biodiversity while allowing for sustainable use. Conservation efforts are ongoing, including programs to improve water quality, control crown-of-thorns starfish, and research into heat-tolerant coral species.

Indigenous Australians have a long relationship with the reef, dating back tens of thousands of years. Aboriginal and Torres Strait Islander peoples are the Traditional Owners of the Great Barrier Reef region, and their heritage is closely linked to the land and sea. Traditional use of marine resources continues to be an important part of their culture and economy.
''',
      questions: [
        QuestionModel(
          question: 'Where is the Great Barrier Reef located?',
          options: [
            'Off the coast of Florida',
            'Off the coast of Queensland',
            'In the Indian Ocean',
            'In the Mediterranean Sea',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The Great Barrier Reef is visible from space.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What are coral polyps?',
          options: ['Plants', 'Rocks', 'Tiny organisms', 'Fish'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'When was the reef selected as a World Heritage Site?',
          options: ['1971', '1981', '1991', '2001'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'How many species of fish does the reef host?',
          options: ['500', '1,000', '1,500', '2,000'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Climate change is considered a minor threat to the reef.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What causes coral bleaching?',
          options: [
            'Pollution',
            'Rising water temperatures',
            'Overfishing',
            'Starfish',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Crown-of-thorns starfish help the coral grow.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'How much does tourism generate annually?',
          options: ['\$1 billion', '3 billion', '6 billion', '10 billion'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Indigenous Australians have no historical connection to the reef.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'The dugong is listed as:',
          options: ['Extinct', 'Vulnerable', 'Common', 'Invasive'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Pollution from farms is not a threat to the reef.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Who manages the reef?',
          options: [
            'The UN',
            'The Great Barrier Reef Marine Park Authority',
            'Greenpeace',
            'The US Navy',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Scientists are researching heat-tolerant coral species.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
      ],
    ),
    ReadingTestModel(
      id: 'reading_8',
      difficulty: 'Medium',
      title: 'The Silk Road',
      passage: '''
The Silk Road was a network of trade routes connecting the East and West, and was central to the economic, cultural, political, and religious interactions between these regions from the 2nd century BCE to the 18th century. The Silk Road primarily refers to the land routes connecting East Asia and Southeast Asia with South Asia, Persia, the Arabian Peninsula, East Africa, and Southern Europe. The Silk Road derives its name from the lucrative trade in silk, carried out along its length, beginning in the Han dynasty in China (207 BCE–220 CE).

Though silk was the major trade item exported from China, many other goods were traded, as well as religions, syncretic philosophies, sciences, and technologies. Diseases, most notably plague, also spread along the Silk Road. In addition to economic trade, the Silk Road was a route for cultural trade among the civilizations along its network. Chinese, Arabs, Somalis, Syrians, Jews, Persians, Greeks, Romans, and Indians engaged in this trade.

The main traders during antiquity were the Indian and Bactrian traders, then from the 5th to the 8th century CE the Sogdian traders, and then afterward the Arab and Persian traders. The transport of goods was achieved by a variety of pack animals, but the camel was the most common. The dromedary camel was used in the hot, dry deserts of the Middle East, while the Bactrian camel was used in the cold, mountainous regions of Central Asia.

The Silk Road was not a single road, but a network of routes. The northern route started at Chang'an (now Xi'an), the capital of the ancient Chinese Kingdom, and went west to the Gobi Desert. The southern route went through the Karakoram Mountains. Maritime routes were also part of this network, connecting China to Southeast Asia, India, the Arabian Peninsula, and Africa.

The decline of the Silk Road began in the late 15th century with the Age of Discovery. European powers, seeking to bypass the Ottoman Empire's control of trade routes, began to explore sea routes to Asia. The discovery of a sea route to India by Vasco da Gama in 1498 marked the beginning of the end for the overland Silk Road. However, the legacy of the Silk Road lives on in the cultural exchange and globalization that characterizes the modern world.
''',
      questions: [
        QuestionModel(
          question: 'The Silk Road connected which two major regions?',
          options: [
            'North and South',
            'East and West',
            'Europe and Africa',
            'Asia and America',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The Silk Road was named after the trade in:',
          options: ['Spices', 'Gold', 'Silk', 'Tea'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Only goods were traded along the Silk Road.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Which animal was most commonly used for transport?',
          options: ['Horse', 'Donkey', 'Camel', 'Elephant'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The Bactrian camel was used in hot deserts.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'The Silk Road consisted of a single road.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Where did the northern route start?',
          options: ['Beijing', 'Shanghai', 'Chang\'an', 'Hong Kong'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Maritime routes were not part of the Silk Road network.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'When did the decline of the Silk Road begin?',
          options: [
            '12th century',
            '15th century',
            '18th century',
            '20th century',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Who discovered a sea route to India in 1498?',
          options: [
            'Christopher Columbus',
            'Marco Polo',
            'Vasco da Gama',
            'Ferdinand Magellan',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'The Ottoman Empire controlled trade routes, prompting Europeans to seek sea routes.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Diseases did not spread along the Silk Road.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Which traders were dominant from the 5th to 8th century CE?',
          options: ['Indian', 'Arab', 'Sogdian', 'Chinese'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The Silk Road has no legacy in the modern world.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
      ],
    ),
    ReadingTestModel(
      id: 'reading_9',
      difficulty: 'Hard',
      title: 'The Science of Sleep',
      passage: '''
Sleep is a naturally recurring state of mind and body, characterized by altered consciousness, relatively inhibited sensory activity, reduced muscle activity and inhibition of nearly all voluntary muscles during rapid eye movement (REM) sleep, and reduced interactions with surroundings. It is distinguished from wakefulness by a decreased ability to react to stimuli, but more reactive than a coma or disorders of consciousness, with sleep displaying very different and active brain patterns.

Sleep occurs in repeating periods, in which the body alternates between two distinct modes: REM sleep and non-REM sleep. Although REM stands for "rapid eye movement", this mode of sleep has many other aspects, including virtual paralysis of the body. A well-known feature of sleep is the dream, an experience typically recounted in narrative form, which resembles waking life while in progress, but which can usually be distinguished as fantasy. During sleep, most of the body's systems are in an anabolic state, helping to restore the immune, nervous, skeletal, and muscular systems. These are vital processes that maintain mood, memory, and cognitive function, and play a large role in the function of the endocrine and immune systems.

The internal circadian clock promotes sleep daily at night. The diverse purposes and mechanisms of sleep are the subject of substantial ongoing research. Sleep is a highly conserved behavior across animal evolution. Humans may suffer from various sleep disorders, including dyssomnias such as insomnia, hypersomnia, and sleep apnea; parasomnias such as sleepwalking and REM sleep behavior disorder; bruxism; and circadian rhythm sleep disorders.

The amount of sleep needed varies by age and individual. The National Sleep Foundation recommends that adults aged 18–64 get 7–9 hours of sleep per night. Sleep deprivation can lead to a variety of health problems, including weight gain, diabetes, heart disease, and depression. It also impairs cognitive function, reaction time, and decision-making abilities.

Research into sleep has revealed that the brain is far from inactive during sleep. In fact, some areas of the brain are more active during sleep than during wakefulness. This activity is thought to be involved in memory consolidation, the process by which short-term memories are converted into long-term memories. This explains why a good night's sleep is often recommended before a big exam or important event.
''',
      questions: [
        QuestionModel(
          question: 'Sleep is characterized by increased sensory activity.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What does REM stand for?',
          options: [
            'Rapid Eye Motion',
            'Rapid Eye Movement',
            'Real Eye Movement',
            'Random Eye Motion',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'During REM sleep, the body experiences virtual paralysis.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Dreams typically occur during which state?',
          options: ['Non-REM sleep', 'REM sleep', 'Deep sleep', 'Light sleep'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Sleep helps restore which of the following systems?',
          options: ['Immune', 'Nervous', 'Skeletal', 'All of the above'],
          correctAnswerIndex: 3,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'The internal circadian clock promotes sleep during the day.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Insomnia is classified as a:',
          options: [
            'Parasomnia',
            'Dyssomnia',
            'Circadian rhythm disorder',
            'Bruxism',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'How many hours of sleep does the National Sleep Foundation recommend for adults?',
          options: ['5-7 hours', '6-8 hours', '7-9 hours', '8-10 hours'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Sleep deprivation can lead to weight loss.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'The brain is completely inactive during sleep.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Memory consolidation occurs during sleep.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Sleep apnea is mentioned as a sleep disorder.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Sleep is a behavior found only in humans.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Sleep deprivation impairs reaction time.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
      ],
    ),
    ReadingTestModel(
      id: 'reading_10',
      difficulty: 'Hard',
      title: 'The Industrial Revolution',
      passage: '''
The Industrial Revolution was the transition to new manufacturing processes in Great Britain, continental Europe, and the United States, in the period from about 1760 to sometime between 1820 and 1840. This transition included going from hand production methods to machines, new chemical manufacturing and iron production processes, the increasing use of steam power and water power, the development of machine tools and the rise of the mechanized factory system. The Industrial Revolution also led to an unprecedented rise in the rate of population growth.

Textiles were the dominant industry of the Industrial Revolution in terms of employment, value of output and capital invested. The textile industry was also the first to use modern production methods. The Industrial Revolution began in Great Britain, and many of the technological innovations were of British origin. By the mid-18th century Britain was the world's leading commercial nation, controlling a global trading empire with colonies in North America and the Caribbean, and with major political influence on the Indian subcontinent.

The introduction of the steam engine, improved by James Watt, was a pivotal moment. Steam engines were initially used to pump water out of mines but were soon adapted to power machinery in factories and transport systems like railways and steamships. This allowed factories to be built anywhere, not just near water sources. The iron industry also saw major advances, with the use of coke instead of charcoal to smelt iron, leading to cheaper and higher quality iron for construction and machinery.

The Industrial Revolution brought about significant social changes. Urbanization accelerated as people moved from rural areas to cities in search of work in factories. This led to overcrowding, poor sanitation, and the spread of disease in the growing industrial cities. Working conditions in factories were often harsh, with long hours, low wages, and dangerous machinery. Child labor was common. These conditions eventually led to the rise of labor unions and labor laws aimed at protecting workers.

Despite the hardships, the Industrial Revolution also resulted in a rise in the standard of living for the general population in the long term. It marked a major turning point in history; almost every aspect of daily life was influenced in some way. Average income and population began to exhibit unprecedented sustained growth.
''',
      questions: [
        QuestionModel(
          question: 'When did the Industrial Revolution approximately begin?',
          options: ['1700', '1760', '1800', '1850'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'Which industry was dominant during the Industrial Revolution?',
          options: ['Iron', 'Coal', 'Textiles', 'Agriculture'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The Industrial Revolution began in the United States.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Who improved the steam engine?',
          options: [
            'Thomas Edison',
            'James Watt',
            'Alexander Graham Bell',
            'Henry Ford',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Steam engines were first used to power trains.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What replaced charcoal in iron smelting?',
          options: ['Wood', 'Coal', 'Coke', 'Gas'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Urbanization decreased during the Industrial Revolution.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Working conditions in early factories were generally safe and comfortable.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Child labor was rare during this period.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What led to the rise of labor unions?',
          options: [
            'High wages',
            'Harsh working conditions',
            'Government mandates',
            'Religious beliefs',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'The standard of living eventually rose for the general population.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Britain was the world\'s leading commercial nation by the mid-18th century.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'The transition included going from machine production to hand production.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Population growth slowed down during the Industrial Revolution.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
      ],
    ),
    ReadingTestModel(
      id: 'reading_11',
      difficulty: 'Hard',
      title: 'Marine Biology: Whales',
      passage: '''
Whales are a widely distributed and diverse group of fully aquatic placental marine mammals. They are an informal grouping within the infraorder Cetacea, which usually excludes dolphins and porpoises. Whales, dolphins and porpoises belong to the order Cetartiodactyla, which consists of even-toed ungulates. Their closest living relatives are the hippopotamuses, having diverged about 40 million years ago. The two parvorders of whales, baleen whales (Mysticeti) and toothed whales (Odontoceti), are thought to have split apart around 34 million years ago.

Whales are creatures of the open ocean; they feed, mate, give birth, suckle and raise their young at sea. So extreme is their adaptation to life underwater that they are unable to survive on land. Whales range in size from the 2.6-metre (8.5 ft) and 135-kilogram (298 lb) dwarf sperm whale to the 29.9-metre (98 ft) and 190-metric-ton (210-short-ton) blue whale, which is the largest creature that has ever lived. The blue whale is even larger than the largest dinosaur.

Baleen whales have no teeth; instead they have plates of baleen, a fringe-like structure used to filter food from the water. They feed on plankton, krill, and small fish. Toothed whales, as the name suggests, have teeth and hunt fish and squid. Sperm whales are known to dive to great depths to hunt giant squid. Whales breathe air through blowholes located on the top of their heads.

Whales have a complex social structure and communication system. Many species are highly vocal, using a variety of clicks, whistles, and pulsed calls to communicate. The songs of humpback whales are particularly famous; these complex sequences of moans, howls, and cries can last for hours and are thought to be used in mating rituals. Whales are also known for their intelligence and ability to learn and teach behaviors.

Whaling, the hunting of whales for their meat and blubber, has a long history. By the 20th century, industrial whaling had driven many species to the brink of extinction. The International Whaling Commission (IWC) banned commercial whaling in 1986. While some populations have recovered, others remain endangered. Threats to whales today include ship strikes, entanglement in fishing gear, ocean noise pollution, and climate change.
''',
      questions: [
        QuestionModel(
          question: 'Whales are closest relatives to which animal?',
          options: ['Sharks', 'Dolphins', 'Hippopotamuses', 'Seals'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'When did baleen and toothed whales diverge?',
          options: [
            '10 million years ago',
            '20 million years ago',
            '34 million years ago',
            '40 million years ago',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Whales can survive on land for short periods.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What is the largest creature that has ever lived?',
          options: ['T-Rex', 'Megalodon', 'Blue Whale', 'Sperm Whale'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Baleen whales use teeth to chew their food.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What do sperm whales hunt?',
          options: ['Plankton', 'Krill', 'Giant Squid', 'Seals'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Whales breathe through gills.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Humpback whale songs are thought to be used for:',
          options: [
            'Navigation',
            'Hunting',
            'Mating rituals',
            'Warning predators',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'When was commercial whaling banned by the IWC?',
          options: ['1970', '1986', '2000', '2010'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'All whale populations have fully recovered.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Which is NOT mentioned as a current threat to whales?',
          options: [
            'Ship strikes',
            'Plastic pollution',
            'Ocean noise',
            'Climate change',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Whales are part of the infraorder Cetacea.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 0,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Dolphins are usually included in the informal grouping of "whales".',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Whales give birth on land.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
      ],
    ),
    ReadingTestModel(
      id: 'reading_12',
      difficulty: 'Hard',
      title: 'The History of Photography',
      passage: '''
Photography is the art, application, and practice of creating durable images by recording light, either chemically by means of a light-sensitive material such as photographic film, or electronically by means of an image sensor. The word "photography" was created from the Greek roots phōtos, meaning "light", and graphé, meaning "drawing" or "writing", together meaning "drawing with light".

The history of photography began in remote antiquity with the discovery of two critical principles: camera obscura image projection and the observation that some substances are visibly altered by exposure to light. There are no artifacts or descriptions that indicate any attempt to capture images with light sensitive materials prior to the 18th century. Around 1717, Johann Heinrich Schulze captured cut-out letters on a bottle of a light-sensitive slurry, but he never thought to make the results durable.

The first permanent photoetching was an image produced in 1822 by the French inventor Nicéphore Niépce, but it was destroyed in a later attempt to make prints from it. Niépce was successful again in 1825. In 1826 or 1827, he made the View from the Window at Le Gras, the earliest surviving photograph from nature. Niépce's process required an extremely long exposure time, lasting at least eight hours and possibly as long as several days.

Niépce later partnered with Louis Daguerre, who went on to develop the daguerreotype process, the first publicly announced and commercially viable photographic process. The daguerreotype required only minutes of exposure in the camera and produced clear, finely detailed results. It was introduced to the world in 1839, a date generally accepted as the birth year of practical photography.

Meanwhile, in England, William Henry Fox Talbot had been working on his own process, the calotype, which used paper coated with silver iodide. Unlike the daguerreotype, which produced a unique positive image on a metal plate, the calotype produced a negative image on paper. This negative could be used to make multiple positive prints, a concept that formed the basis of modern chemical photography.

Throughout the 19th and 20th centuries, photography continued to evolve with the introduction of flexible film, color photography, and eventually digital photography. The first digital camera was created by Steven Sasson at Eastman Kodak in 1975. It weighed 3.6 kilograms (8 lbs) and took 23 seconds to record a black and white image to a cassette tape. Today, digital photography has largely replaced chemical photography, with high-quality cameras integrated into smartphones used by billions of people worldwide.
''',
      questions: [
        QuestionModel(
          question: 'What does the word "photography" mean?',
          options: [
            'Capturing reality',
            'Drawing with light',
            'Picture making',
            'Chemical art',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'The principles of camera obscura were discovered in the 18th century.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Who produced the earliest surviving photograph from nature?',
          options: [
            'Louis Daguerre',
            'William Henry Fox Talbot',
            'Nicéphore Niépce',
            'Johann Heinrich Schulze',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question:
              'How long was the exposure time for the View from the Window at Le Gras?',
          options: ['Seconds', 'Minutes', 'At least 8 hours', 'One hour'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The daguerreotype was introduced in which year?',
          options: ['1822', '1826', '1839', '1850'],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The daguerreotype produced a negative image on paper.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'What was the main advantage of the calotype process?',
          options: [
            'It was faster',
            'It produced multiple prints from a negative',
            'It was in color',
            'It used metal plates',
          ],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'Who created the first digital camera?',
          options: [
            'Steve Jobs',
            'Bill Gates',
            'Steven Sasson',
            'George Eastman',
          ],
          correctAnswerIndex: 2,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'When was the first digital camera created?',
          options: ['1975', '1985', '1995', '2000'],
          correctAnswerIndex: 0,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The first digital camera recorded images to a hard drive.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'Digital photography has not yet replaced chemical photography.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question: 'Johann Heinrich Schulze made his images durable.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
        QuestionModel(
          question:
              'The first digital camera took how long to record an image?',
          options: ['1 second', '23 seconds', '1 minute', '5 minutes'],
          correctAnswerIndex: 1,
          questionType: 'multiple_choice',
        ),
        QuestionModel(
          question: 'The daguerreotype required days of exposure.',
          options: ['True', 'False', 'Not Given'],
          correctAnswerIndex: 1,
          questionType: 'true_false_not_given',
        ),
      ],
    ),
  ];
}
