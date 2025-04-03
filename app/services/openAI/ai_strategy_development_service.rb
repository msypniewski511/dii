# # app/services/open_ai/ai_strategy_development_service.rb
# module OpenAI
#   class AiStrategyDevelopmentService
#     def self.generate(section, business_idea)
#       competitor_summary = business_idea
#         .competitor_analysis
#         .last
#         &.competitors
#         &.limit(3)
#         &.map { |c| "#{c.name}: #{c.five_forces&.truncate(3000)}" }
#         &.join("\n\n")
#       context = <<~CONTEXT
#         Business Title: #{business_idea.title}
#         Description: #{business_idea.description}
#         Country: #{business_idea.country}

#         Business Idea Summary:
#         #{business_idea.business_idea_definition&.ai_summary}

#         Market Research Insights:
#         #{business_idea.market_research&.ai_suggestions}

#         Competitor Summary (truncated):
#         #{competitor_summary}
#       CONTEXT
#       # if context.size > 7500
#       #   Rails.logger.warn("Context too long: truncating to fit OpenAI limits")
#       #   context = context.truncate(7500)
#       # end
#       puts context
#       puts context.length / 4
#       prompt = if section == "core_strategy"
#         <<~PROMPT
#           Using the business context provided, generate a detailed "Core Strategy" for the startup, including:

#           - SMART Strategic Goals (specific, measurable, achievable, relevant, time-bound)
#           - Core strategic initiatives
#           - Highlighted section labeled **Scaling Strategy**, focusing on how the business will grow, expand, or scale operations over time.

#           Format Scaling Strategy like this:

#           **Scaling Strategy:**
#           - Detail 1
#           - Detail 2
#           ...

#           Context:
#           #{context}

#           Return only the generated content.
#         PROMPT
#       elsif section == "strategic_goals"
#         <<~PROMPT
#           Using the business context provided, generate outputs:

#           1. A **readable SMART Goal summary** — list clear goals with bullet points
#             For each goal, provide:
#             - Description (S)
#             - Measurement criteria (M)
#             - Achievability explanation (A)
#             - Relevance to the business (R)
#             - Time-bound target (T).
#           2. A **structured JSON array** — each object includes:
#              - `title` (short)
#              - `description` (one sentence)
#              - `category` (e.g., Marketing, Product, Finance)
#              - `start_date` (estimated YYYY-MM-DD)
#              - `due_date` (estimated YYYY-MM-DD)
#              - `milestone` (true if major milestone)

#           Format like:

#           ---
#           **SMART GOALS:**
#           - Goal 1
#           - Goal 2
#           - Goal 3
#           - Goal 4
#           - Goal 5
#           ...

#           ---
#           **GOALS_JSON:**
#           [
#             { "title": "...", "description": "...", "start_date": "...", ... },
#             ...
#           ]

#           Context:
#           #{context}

#           Return both the formatted version and the JSON block.
#         PROMPT      
#       else
#         <<~PROMPT
#           Using the business context provided, generate a detailed section for "#{section.humanize}" in a startup's strategic development plan.

#           Context:
#           #{context}

#           Return only the generated content without explanation.
#         PROMPT
#       end

#       OpenAiService.generate_text(prompt)
#     end

#     def self.parse_and_save_smart_goals(response, business_idea)
#       content = response.to_s

#       json_part = content[/\*\*GOALS_JSON:\*\*\s*(\[.*?\])\s*\z/m, 1]
#       return unless json_part

#       begin
#         goals = JSON.parse(json_part)

#         goals.each do |goal|
#           business_idea.smart_goals.create!(
#             title: goal["title"],
#             description: goal["description"],
#             category: goal["category"],
#             start_date: goal["start_date"],
#             due_date: goal["due_date"],
#             milestone: goal["milestone"]
#           )
#         end
#       rescue JSON::ParserError => e
#         Rails.logger.error "SMART Goals JSON parse error: #{e.message}"
#       end
#     end
#   end
# end
# app/services/open_ai/ai_strategy_development_service.rb
module OpenAI
  class AiStrategyDevelopmentService
    MAX_CONTEXT_TOKENS = 7000
    MAX_CONTEXT_CHARS = MAX_CONTEXT_TOKENS * 4

    def self.generate(section, business_idea)
      competitor_summary = business_idea
        .competitor_analysis
        .last
        &.competitors
        &.limit(3)
        &.map { |c| "#{c.name}: #{c.five_forces&.truncate(3000)}" }
        &.join("\n\n")

      context = <<~CONTEXT
        Business Title: #{business_idea.title}
        Description: #{business_idea.description}
        Country: #{business_idea.country}

        Business Idea Summary:
        #{business_idea.business_idea_definition&.ai_summary}

        Market Research Insights:
        #{business_idea.market_research&.ai_suggestions}

        Competitor Summary:
        #{competitor_summary}
      CONTEXT

      context = context.truncate(MAX_CONTEXT_CHARS) if context.length > MAX_CONTEXT_CHARS

      prompt = case section
      when "core_strategy"
        <<~PROMPT
          Using the business context provided, generate a detailed "Core Strategy" for the startup, including:

          - SMART Strategic Goals (specific, measurable, achievable, relevant, time-bound)
          - Core strategic initiatives
          - Highlighted section labeled **Scaling Strategy**, focusing on how the business will grow, expand, or scale operations over time.

          Format Scaling Strategy like this:

          **Scaling Strategy:**
          - Detail 1
          - Detail 2
          ...

          Context:
          #{context}

          Return only the generated content.
        PROMPT
      when "strategic_goals"
        # <<~PROMPT
        #   Using the business context provided, generate outputs:

        #   1. A **readable SMART Goal summary** — list clear goals with bullet points.
        #     For each goal, provide:
        #     - Description (S)
        #     - Measurement criteria (M)
        #     - Achievability explanation (A)
        #     - Relevance to the business (R)
        #     - Time-bound target (T).
        #   2. A **structured JSON array** — each object includes:
        #      - `title`, `description`, `category`, `start_date`, `due_date`, `milestone`.

        #   Format:

        #   ---
        #   **SMART GOALS:**
        #   - Goal 1
        #   - Goal 2
        #   ...

        #   ---
        #   **GOALS_JSON:**
        #   [ { "title": "...", "description": "...", ... } ]

        #   Context:
        #   #{context}

        #   Return both the formatted version and the JSON block.
        # PROMPT
        <<~PROMPT
          Using the business context provided, generate min 5 times - outputs:

          1. A **readable SMART Goal summary** with no leading "Goal 1:", no blank lines, and no extra spacing.  
            Each goal should be title and in bullet point format, and each line should use short SMART tags like:
            - (S) ...
            - (M) ...
            - (A) ...
            - (R) ...
            - (T) ...

            Example:
            Grow user base
            - (S) Grow user base to 10,000 by Q3
            - (M) Track registrations via dashboard
            - (A) Achievable through digital marketing campaigns
            - (R) Aligns with our growth model
            - (T) Targeted for Q3 2025

          2. A **structured JSON array** — each object includes:
            - `title`, `description`, `category`, `start_date`, `due_date`, `milestone`.

          Output format:

          ---
          **SMART GOALS:**
          **Grow user base**
          - (S) ...
          - (M) ...
          - (A) ...
          - (R) ...
          - (T) ...

          ---
          **GOALS_JSON:**
          [ { "title": "...", "description": "...", ... } ]

          Context:
          #{context}

          Return both sections clearly. No "Goal 1", no unnecessary spacing.
        PROMPT
      else
        <<~PROMPT
          Using the business context provided, generate a detailed section for "#{section.humanize}" in a startup's strategic development plan.

          Context:
          #{context}

          Return only the generated content without explanation.
        PROMPT
      end

      OpenAiService.generate_text(prompt)
    end

    def self.parse_and_save_smart_goals(response, business_idea)
      json_part = response[/\*\*GOALS_JSON:\*\*\s*(\[.*?\])\s*\z/m, 1]
      return unless json_part

      begin
        JSON.parse(json_part).each do |goal|
          business_idea.smart_goals.create!(
            title: goal["title"],
            description: goal["description"],
            category: goal["category"],
            start_date: goal["start_date"],
            due_date: goal["due_date"],
            milestone: goal["milestone"]
          )
        end
      rescue JSON::ParserError => e
        Rails.logger.error "SMART Goals JSON parse error: #{e.message}"
      end
    end
  end
end
