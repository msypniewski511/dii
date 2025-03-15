module OpenAI
  class GenerateBusinessModelCanvas
    def self.call(business_idea)
      client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
      
      prompt = <<~PROMPT
        Generate a structured Business Model Canvas for a company in the #{business_idea.industry_type.name} industry and country #{business_idea.country} described: #{business_idea.description}.
        The response should include:
        - Key Partners
        - Key Activities
        - Key Resources
        - Value Propositions
        - Customer Relationships
        - Channels
        - Customer Segments
        - Cost Structure
        - Revenue Streams
      PROMPT

      response = client.chat(
        parameters: { 
          model: "gpt-4", 
          messages: [{ role: "system", content: prompt }], 
          max_tokens: 1500 }
      )
      puts "pizda"
      puts response
      
      parse_response(response)
    end

    private

    def self.parse_response(response)
      content = response.dig("choices", 0, "message", "content")
    
      puts "------------------"
      puts content
      puts "------------------"
    
      return {} unless content
    
      # Initialize structured hash with default empty values
      sections = {
        key_partners: "",
        key_activities: "",
        key_resources: "",
        value_propositions: "",
        customer_relationships: "",
        channels: "",
        customer_segments: "",
        cost_structure: "",
        revenue_streams: ""
      }
    
      # Define mapping between AI section names and our database keys
      section_mapping = {
        "key partners" => :key_partners,
        "key activities" => :key_activities,
        "key resources" => :key_resources,
        "value propositions" => :value_propositions,
        "customer relationships" => :customer_relationships,
        "channels" => :channels,
        "customer segments" => :customer_segments,
        "cost structure" => :cost_structure,
        "revenue streams" => :revenue_streams
      }
    
      # Normalize AI response (remove unwanted characters)
      normalized_content = content.gsub(/^\d+\.\s/, "") # Remove "1. ", "2. ", etc.
                                  .gsub(/^I{1,3}V?\.\s/, "") # Remove Roman numerals ("I.", "II.")
                                  .gsub(":", "") # Remove colons after headers
    
      # Extract sections using regex
      current_section = nil
      normalized_content.lines.each do |line|
        line = line.strip
    
        # Detect headers (e.g., "**Key Partners**", "Key Partners", "I. Key Partners", etc.)
        section_title = line.gsub("**", "").strip.downcase
        if section_mapping.key?(section_title)
          current_section = section_mapping[section_title]
        
        # If it's a bullet point or numbered item, add to the current section
        elsif current_section && line.match?(/^(-|\d+\.)\s/)
          sections[current_section] += "#{line.gsub(/^(-|\d+\.)\s/, "").strip}\n"
        end
      end
    
      # Ensure no section is empty by setting a default fallback text
      sections.each do |key, value|
        sections[key] = value.strip.empty? ? "No data available for this section." : value.strip
      end
    
      puts "Parsed Sections:"
      puts sections
    
      sections
    end    
  end
end
