# module OpenAI
#   class FinancialPlanService
#     def self.generate_section(section, business_idea)
#       definition = business_idea.business_idea_definition
#       research   = business_idea.market_research
#       strategy   = business_idea.strategy_development

#       prompt = build_prompt(section, business_idea, definition, research, strategy)
#       response = OpenAiService.generate_text(prompt)
#       response.strip
#     end

#     def self.build_prompt(section, business_idea, definition, research, strategy)
#       case section
#       when "startup_costs"
#         <<~PROMPT
#           Provide a detailed breakdown of startup costs for a new business called "#{business_idea.title}".
#           Country: #{business_idea.country}
#           Industry: #{business_idea.industry_type&.name}
#           Business Summary: #{definition&.ai_summary}

#           Include estimates for:
#           - Equipment and tech
#           - Marketing
#           - Legal/admin fees
#           - Initial operations setup

#           Format in clear bullet points or structured blocks.
#         PROMPT

#       when "revenue_forecasts"
#         <<~PROMPT
#           Estimate revenue forecasts for "#{business_idea.title}", a business in #{business_idea.country} targeting #{definition&.target_customer_segment}.
#           Value Proposition: #{definition&.value_proposition}
#           Market Trends: #{research&.market_trends}

#           Consider pricing strategy and expected customer growth over the next 12 months.
#         PROMPT

#       when "cost_forecasts"
#         <<~PROMPT
#           Generate cost forecasts for "#{business_idea.title}".
#           Include:
#           - Fixed costs (rent, wages, subscriptions)
#           - Variable costs (materials, delivery, production)

#           Use context from strategy and business model if helpful.
#         PROMPT

#       # Add similar when-cases for other sections...
#       else
#         "Generate a financial planning insight for #{section.humanize} for the business idea: #{business_idea.title}."
#       end
#     end
#   end
# end
module OpenAI
  class FinancialPlanService
    def self.generate_section(section, business_idea)
      definition = business_idea.business_idea_definition
      research   = business_idea.market_research
      strategy   = business_idea.strategy_development
      plan       = business_idea.financial_plan

      prompt = build_prompt(section, business_idea, definition, research, strategy, plan)
      response = OpenAiService.generate_text(prompt)
      response.strip
    end

    def self.build_prompt(section, business_idea, definition, research, strategy, plan)
      case section
      when "startup_costs"
        <<~PROMPT
          Provide a detailed breakdown of startup costs for a new business called "#{business_idea.title}".
          Country: #{business_idea.country}
          Industry: #{business_idea.industry_type&.name}
          Business Summary: #{definition&.ai_summary}

          Include estimates for:
          - Equipment and tech
          - Marketing
          - Legal/admin fees
          - Initial operations setup

          Format in clear bullet points or structured blocks.
        PROMPT

      when "revenue_forecasts"
        <<~PROMPT
          Estimate revenue forecasts for "#{business_idea.title}", a business in #{business_idea.country} targeting #{definition&.target_customer_segment}.
          Value Proposition: #{definition&.value_proposition}
          Market Trends: #{research&.market_trends}

          Consider pricing strategy and expected customer growth over the next 12 months.
          Format clearly with estimated revenue per month or quarter.
        PROMPT

      when "cost_forecasts"
        <<~PROMPT
          Generate cost forecasts for "#{business_idea.title}".
          Include:
          - Fixed costs (rent, wages, subscriptions)
          - Variable costs (materials, delivery, production)

          Context:
          Industry: #{business_idea.industry_type&.name}
          Scaling Strategy: #{extract_scaling_strategy(strategy&.core_strategy)}

          Format as a breakdown with approximate monthly values.
        PROMPT

      when "break_even_analysis"
        <<~PROMPT
          Based on the revenue forecast:
          #{plan&.revenue_forecasts}

          And cost forecast:
          #{plan&.cost_forecasts}

          Calculate the break-even point for the business "#{business_idea.title}" — how many units/customers are needed to cover the total costs.

          Provide:
          - Monthly break-even estimate
          - Short explanation of calculation
          - If possible, express it visually (ASCII chart or labeled numbers)
        PROMPT

      when "cash_flow_forecast"
        <<~PROMPT
          Using the provided revenue and cost forecast:

          Revenue:
          #{plan&.revenue_forecasts}

          Costs:
          #{plan&.cost_forecasts}

          Create a cash flow forecast for the first 12 months of operation.
          Include:
          - Monthly inflow/outflow
          - Cumulative cash position
          - Highlight months with negative flow

          Format in a month-by-month table style.
        PROMPT

      when "funding_needs"
        scaling_info = extract_scaling_strategy(strategy&.core_strategy)

        <<~PROMPT
          Based on the following startup context, suggest the appropriate funding needs and sources for the business "#{business_idea.title}" in #{business_idea.country}:

          - Business Description: #{business_idea.description}
          - Business Idea Summary: #{definition&.ai_summary}
          - Market Conditions: #{research&.market_trends}
          - Value Proposition: #{definition&.value_proposition}
          - Strategic Goals: #{strategy&.strategic_goals}
          - Scaling Strategy: #{scaling_info}

          📌 Your task:
          1. Identify key milestones that will require funding (e.g., product launch, market expansion, hiring).
          2. Recommend funding amounts and types for each milestone.
          3. Include suitable sources (grants, angel, VC, crowdfunding, bootstrapping).
          4. Prioritize funding methods depending on business maturity and speed of growth.

          Return a structured list with clarity, bullet points, or short paragraphs — no generic advice.
        PROMPT

      when "profit_and_loss"
        <<~PROMPT
          Create a 1-year projected Profit & Loss (P&L) statement for "#{business_idea.title}".

          Use the following context:
          - Revenue forecast data (from revenue_forecasts)
          - Cost structure (from cost_forecasts)
          - Market assumptions (#{research&.market_trends})
          - Business Model Canvas: Revenue Streams & Cost Structure

          Include:
          - Total Revenue
          - Total Costs (split: fixed & variable)
          - Gross Profit
          - Net Profit

          Present in a clear structured format.
        PROMPT

      when "risk_assessment"
        <<~PROMPT
          Perform a financial risk assessment for a business called "#{business_idea.title}" based in #{business_idea.country}.
          
          Business Context:
          Industry: #{business_idea.industry_type&.name}
          Summary: #{definition&.ai_summary}
          Revenue Forecasts: #{business_idea.financial_plan&.revenue_forecasts}
          Cost Forecasts: #{business_idea.financial_plan&.cost_forecasts}
          Strategy: #{strategy&.core_strategy}

          Identify major risks such as:
          - Market volatility
          - Currency and inflation risk
          - Payment delays
          - Scaling risks
          - Legal/operational risks

          Then provide 3–5 **clear mitigation strategies**.

          Format:
          - Risk: Description
            Mitigation: Strategy
        PROMPT

      when "kpi_milestones"
        <<~PROMPT
          Based on the following business context, generate a list of relevant **financial KPIs** and **milestones** to help the founder track startup performance.

          Business Name: #{business_idea.title}
          Country: #{business_idea.country}
          Industry: #{business_idea.industry_type&.name}
          Revenue Forecasts: #{business_idea.financial_plan&.revenue_forecasts}
          Strategy: #{strategy&.core_strategy}

          🔢 KPIs to consider:
          - Monthly Burn Rate
          - CAC / LTV
          - Gross Margin
          - Revenue Milestones
          - Break-even
          - Optional: industry-specific metrics

          Format as:
          - KPI: Description
          - Milestone: Description + Timing
        PROMPT

      else
        "Generate a financial planning insight for #{section.humanize} for the business idea: #{business_idea.title}."
      end
    end

    def self.extract_scaling_strategy(core_strategy)
      return "" if core_strategy.blank?

      scaling_block = core_strategy[/\*\*Scaling Strategy:\*\*(.+)/m, 1]
      scaling_block ? scaling_block.strip : ""
    end
  end
end
