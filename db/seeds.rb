# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# questions = [
#   { category: "Leadership & Vision", text: "Do you have a clear vision for your business or project?" },
#   { category: "Risk-Taking & Decision-Making", text: "How comfortable are you with taking risks?" },
#   { category: "Problem-Solving & Innovation", text: "How do you approach problems in business?" },
#   { category: "Financial & Business Management", text: "How well do you manage your business finances?" },
#   { category: "Marketing & Customer Focus", text: "Do you understand your target audience?" },
#   { category: "Resilience & Adaptability", text: "How do you handle business failures or setbacks?" }
# ]

# questions.each do |q|
#   question = Question.create!(q)

#   [
#     { text: "I have no idea", score: 1 },
#     { text: "I have a vague idea", score: 2 },
#     { text: "I somewhat understand", score: 3 },
#     { text: "I understand well", score: 4 },
#     { text: "I fully understand and apply", score: 5 }
#   ].each do |a|
#     question.answers.create!(a)
#   end
# end

questions_and_answers = [
  [
    [ { category: "Leadership & Vision", text: "Do you have a clear vision for your business or project?" } ],
    [
      { score: 1, text: "I have no vision at all" },
      { score: 2, text: "I have some ideas, but they are not clear" },
      { score: 3, text: "I have a general vision but need more details" },
      { score: 4, text: "I have a clear and structured vision" },
      { score: 5, text: "I have a compelling vision and a roadmap to achieve it" },
    ]
  ],
  [
    [ { category: "Leadership & Vision", text: "How well do you communicate your ideas to others?" } ],
    [
      { score: 1, text: "I struggle to explain my ideas" },
      { score: 2, text: "I can explain but with difficulty" },
      { score: 3, text: "I can explain to some people but not everyone" },
      { score: 4, text: "I communicate effectively with most people" },
      { score: 5, text: "I can inspire and convince others with ease" },
    ],
  ],
  [
    [ { category: "Leadership & Vision", text: "Do you take responsibility for your decisions and actions?" } ],
    [
      { score: 1, text: "I often blame others or circumstances" },
      { score: 2, text: "I take responsibility sometimes" },
      { score: 3, text: "I try to take responsibility but struggle" },
      { score: 4, text: "I own my decisions and actions" },
      { score: 5, text: "I take full responsibility and learn from mistakes" }
    ]
  ],
  [
    [ { category: "Risk-Taking & Decision-Making", text: "How comfortable are you with taking risks?" } ],
    [
      { score: 1, text: "I avoid risks at all costs" },
      { score: 2, text: "I take risks only when necessary" },
      { score: 3, text: "I take calculated risks sometimes" },
      { score: 4, text: "I assess risks and take them wisely" },
      { score: 5, text: "I am comfortable taking strategic risks" },
    ]
  ],
  [
    [ { category: "Risk-Taking & Decision-Making", text: "How quickly do you make important decisions?" } ],
    [
      { score: 1, text: "I struggle to make decisions" },
      { score: 2, text: "I take a long time to decide" },
      { score: 3, text: "I make decisions, but with hesitation" },
      { score: 4, text: "I make decisions confidently" },
      { score: 5, text: "I make effective decisions under pressure" },
    ],
  ],
  [
    [ { category: "Problem-Solving & Innovation", text: "How do you approach problems in business?" } ],
    [
      { score: 1, text: "I avoid problems and hope they go away" },
      { score: 2, text: "I get frustrated and struggle to solve them" },
      { score: 3, text: "I try different approaches but lack confidence" },
      { score: 4, text: "I analyze and solve problems methodically" },
      { score: 5, text: "I see problems as opportunities to innovate" },
    ]
  ],
  [
    [ { category: "Problem-Solving & Innovation", text: "How often do you come up with new business ideas?" } ],
    [
      { score: 1, text: "Almost never" },
      { score: 2, text: "Rarely" },
      { score: 3, text: "Occasionally" },
      { score: 4, text: "Frequently" },
      { score: 5, text: "Constantly – I always have new ideas" },
    ]
  ],
  [
    [ { category: "Financial & Business Management", text: "How well do you manage your business finances?" } ],
    [
      { score: 1, text: "I don’t track finances at all" },
      { score: 2, text: "I track finances but don’t fully understand them" },
      { score: 3, text: "I manage basic cash flow and budgeting" },
      { score: 4, text: "I have a clear financial plan and control my costs" },
      { score: 5, text: "I analyze and optimize finances strategically" },
    ]
  ],
  [
    [ { category: "Financial & Business Management", text: "Do you understand key financial metrics for business success?" } ],
    [
      { score: 1, text: "Not at all" },
      { score: 2, text: "I have a basic understanding" },
      { score: 3, text: "I understand some financial metrics" },
      { score: 4, text: "I monitor key financial KPIs regularly" },
      { score: 5, text: "I analyze financial data to improve performance" },
    ]
  ],
  [
    [ { category: "Marketing & Customer Focus", text: "Do you understand your target audience?" } ],
    [
      { score: 1, text: "I have no idea who my target audience is" },
      { score: 2, text: "I have a vague idea but need more research" },
      { score: 3, text: "I know my audience but don’t engage with them well" },
      { score: 4, text: "I actively research and engage with my audience" },
      { score: 5, text: "I deeply understand my audience and their needs" },
    ]
  ],
  [
    [ { category: "Marketing & Customer Focus", text: "How effectively do you market your products or services?" } ],
    [
      { score: 1, text: "I don’t do any marketing" },
      { score: 2, text: "I try but don’t know what works" },
      { score: 3, text: "I use some marketing strategies with mixed results" },
      { score: 4, text: "I have a structured marketing plan" },
      { score: 5, text: "I market effectively and generate strong engagement" },
    ]
  ],
  [
    [ { category: "Resilience & Adaptability", text: "How do you handle business failures or setbacks?" } ],
    [
      { score: 1, text: "I get discouraged and give up easily" },
      { score: 2, text: "I struggle but try to move forward" },
      { score: 3, text: "I learn from failures but still feel discouraged" },
      { score: 4, text: "I see failures as learning experiences" },
      { score: 5, text: "I thrive on challenges and setbacks" },
    ]
  ],
  [
    [ { category: "Resilience & Adaptability", text: "How well do you adapt to changing market conditions?" } ],
    [
      { score: 1, text: "I resist change and struggle to adapt" },
      { score: 2, text: "I find it difficult to adjust but try" },
      { score: 3, text: "I adapt slowly over time" },
      { score: 4, text: "I embrace change and adjust strategies" },
      { score: 5, text: "I anticipate changes and act proactively" },
    ]
  ],
]
# questions_and_answers.each do |qa|
#   question = Question.create!(qa[0].first)
#   qa[1].each do |a|
#     question.answers.create!(a)
#   end
# end

industries = [
  "Technology",
  "Healthcare",
  "Retail",
  "Finance",
  "Manufacturing",
  "Education",
  "Entertainment",
  "Real Estate",
  "Transportation",
  "Energy"
]

industries.each do |name|
  IndustryType.find_or_create_by(name: name)
end