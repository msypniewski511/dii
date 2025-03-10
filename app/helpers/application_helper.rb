module ApplicationHelper
  def bootstrap_breadcrumb
   # Define your breadcrumb structure
   breadcrumbs = {
    "home" => { 
      index: ["Dashboard"]
    },
    "articles" => {
      index: ["Dashboard", ["Articles", articles_path]],
      show: ["Dashboard", ["Articles", articles_path], -> { @article.id }],
      new: ["Dashboard", ["Articles", articles_path], "New Article"],
      edit: ["Dashboard", ["Articles", articles_path], -> { "Edit: #{@article.id}" }]
    },
    "brands" => {
      index: ["Dashboard", ["Brand", brands_path]],
      show: ["Dashboard", ["Brand", brands_path], -> { @brand.business_name }],
      new: ["Dashboard", ["Brand", brands_path], "New brand"],
      edit: ["Dashboard", ["Brand", brands_path], -> { "Edit: #{@brand.business_name}" }]
    },
    "business_ideas" => {
      index: ["Dashboard", ["Business Ideas", business_ideas_path]],
      show: ["Dashboard", ["Business Ideas", business_ideas_path], -> { @business_idea.title }],
      new: ["Dashboard", ["Business Ideas", business_ideas_path], "New idea"],
      edit: ["Dashboard", ["Business Ideas", business_ideas_path], -> { "Edit: #{@business_idea.title}" }]
    },
    "ideas" => {
      index: ["Dashboard", ["Ideas", ideas_path]],
      show: ["Dashboard", ["Ideas", ideas_path], -> { @idea.due_date }],
      new: ["Dashboard", ["Ideas", ideas_path], "New idea"],
      edit: ["Dashboard", ["Ideas", ideas_path], -> { "Edit: #{@idea.due_date}" }]
    },
    "pestel_analyses" => {
      index: ["Dashboard", ["Business Ideas", business_ideas_path]],
      show: ["Dashboard", ["Business Ideas", business_ideas_path], ["#{@business_idea ? @business_idea.title : ""}", @business_idea], -> { "PETSEL" } ],
      new: ["Dashboard", ["Business Ideas", business_ideas_path], "New idea"],
      edit: ["Dashboard", ["Business Ideas", business_ideas_path], ["#{@business_idea ? @business_idea.title : ""}", @business_idea], ["PETSE", @business_idea&.persisted? ? business_idea_pestel_analyses_path(@business_idea) : nil], -> { "Edit" }]
    },
    "swot_analyses" => {
      index: ["Dashboard", ["Business Ideas", business_ideas_path]],
      show: ["Dashboard", ["Business Ideas", business_ideas_path], ["#{@business_idea ? @business_idea.title : ""}", @business_idea], -> { "SWOT matrix" } ],
      new: ["Dashboard", ["Business Ideas", business_ideas_path], "New idea"],
      edit: ["Dashboard", ["Business Ideas", business_ideas_path], ["#{@business_idea ? @business_idea.title : ""}", @business_idea], ["SWOT matrix", @business_idea&.persisted? ? business_idea_pestel_analyses_path(@business_idea) : nil], -> { "Edit" }]
    },
    "users" => {
      index: ["Dashboard", ["Users", brands_path]],
      show: ["Dashboard", ["Users", brands_path], -> { @brands.name }]
    }
  }

  # Retrieve breadcrumbs for the current controller and action
  controller_breadcrumbs = breadcrumbs[controller_name] || {}
  action_breadcrumbs = controller_breadcrumbs[action_name.to_sym]

  # Build the breadcrumb items
  breadcrumb_items = action_breadcrumbs&.map do |item|
    if item.is_a?(Array)
      link_to(item[0], item[1], class: 'opacity-5 text-white',  'data-turbo': "false")
    elsif item.is_a?(Proc)
      item.call
    else
      item
    end
  end

  # Render breadcrumbs
  render_breadcrumbs(breadcrumb_items || [])
  end

  def bootstrap_offcanvas_hash(element)
    info = {
      business_name: [
        'Business Name',
        ['<p>In the UK, choosing a business name involves several key steps and legal considerations to ensure it’s unique, memorable, and compliant with regulations. Here’s a quick overview for starting a new business:</p>
  
          <ol>
            <li><strong>Uniqueness Check:</strong> Your business name must be unique and not too similar to existing companies. You can check name availability through the <a href="https://find-and-update.company-information.service.gov.uk/company-name-availability">UK’s Companies House website/Company name availability checker</a>.</li>
            <li><strong>Legal Requirements:</strong> Certain words (like &quot;British,&quot; &quot;Royal,&quot; or &quot;Association&quot;) have restrictions or require permission. The name must not be misleading about the business’s legal status or imply connections it doesn’t have.</li>
            <li><strong>Domain and Social Media:</strong> Consider if the name is available as a domain and on social media platforms to build an online presence.</li>
            <li><strong>Trademark Search:</strong> Conduct a trademark search via the <a href="https://www.gov.uk/government/organisations/intellectual-property-office">Intellectual Property Office (IPO)</a> to ensure the name isn’t trademarked, which could prevent potential legal issues.</li>
            <li><strong>Registering the Name:</strong> For a limited company, you’ll need to register with <strong><a href="https://www.gov.uk/limited-company-formation/register-your-company">Companies House</a></strong>; sole traders don’t need to register, but using your own name or a trading name is typical.
            &gt;A strong business name is vital as it sets the tone for branding and marketing, so it’s worth considering its appeal to your target market as well.
            <a href="https://www.gov.uk/become-sole-trader/choose-your-business-name?step-by-step-nav=01ff8dbd-886a-4dbb-872c-d2092b31b2cf">Choose your business name - GOV.UK</a></li>
          </ol>
        ']
      ],
      strapline: [
        'Strapline',
        ['<blockquote>
          <p>Creating a strapline (also known as a tagline) is an important step in branding your new business. A strapline is a concise and catchy phrase that encapsulates your brand&#39;s essence, value proposition, and personality. Here are some tips for developing an effective strapline:</p>
          </blockquote>

          <ol>
          <li><strong>Reflect Your Brand Identity:</strong>
          Ensure that your strapline aligns with your business values, mission, and overall brand identity. It should convey what makes your business unique.</li>
          <li><strong>Be Concise:</strong>
          Aim for a short and memorable phrase, ideally between 5 to 10 words. The best straplines are easy to remember and repeat.</li>
          <li><strong>Communicate Value:</strong>
          Highlight the benefits of your product or service. What do you offer that your competitors don’t? This could be quality, innovation, customer service, or something else.</li>
          <li><strong>Create Emotional Resonance:</strong>
          Use language that connects emotionally with your target audience. Think about the feelings or aspirations you want to evoke.</li>
          <li><strong>Make It Catchy:</strong>
          Consider using literary devices like alliteration, rhyme, or puns to make your strapline more engaging and memorable.</li>
          <li><strong>Test and Get Feedback:</strong>
          Share your strapline with friends, family, and potential customers to gather feedback. This can help ensure it resonates with your target market.</li>
          <li><strong>Avoid Jargon:</strong>
          Keep the language simple and clear. Avoid industry jargon that might confuse your audience.</li>
          <li><strong>Consider Longevity:</strong>
          Think about how well the strapline will age. Will it still be relevant as your business grows or expands into new areas?</li>
          <li><strong>Be Original:</strong>
          Ensure your strapline is unique and does not closely resemble those of competitors. This helps you stand out in the market.</li>
          </ol>

          <p><strong>Examples of Effective Straplines:</strong></p>

          <ul>
          <li>Nike: “Just Do It.” (Motivational and action-oriented)</li>
          <li>Apple: “Think Different.” (Encourages innovation and uniqueness)</li>
          <li>L’Oreal: “Because You’re Worth It.” (Empowers customers and promotes self-esteem)</li>
          </ul>

          <p>Creating a strong strapline can significantly enhance your branding efforts and help establish a memorable identity for your new business. Take your time to brainstorm and refine your options!</p>']],
      website_domain: ['Website Domain Name',
        ['<p>In the UK, securing the right domain name is key to establishing a strong online presence for your new business. Here are a few tips:</p>

        <ol>
        <li><strong>“.co.uk” Domain:</strong> This is the most common and recognized domain for businesses in the UK, signaling a local presence and trustworthiness to UK customers.</li>
        <li><strong>“.uk” Domain:</strong> Shorter and more modern than “.co.uk,” it’s ideal if you want a concise, fresh look. It’s widely accepted and gives a sleek impression for brands aiming for simplicity.</li>
        <li><strong>Brandable Names:</strong> Choose a unique, brandable name that’s easy to remember and spell. Avoid complex names or hyphens, as these can be hard to recall and impact searchability.</li>
        <li><strong>Keywords and SEO:</strong> If your business idea revolves around specific products or services, consider including keywords in your domain. For instance, a bakery could use “LondonBakery.co.uk” for SEO and clarity.</li>
        <li><strong>Domain Registration Platforms:</strong> Use trusted registrars like <a href="https://www.godaddy.com/en-uk">GoDaddy</a>, <a href="https://www.123-reg.co.uk/">123 Reg</a>, or <a href="https://www.namecheap.com/">Namecheap</a> for purchasing your UK domain. These platforms offer easy registration and tools for managing your domain.</li>
        <li><strong>Check for Trademark Conflicts:</strong> Before committing, verify that the domain name doesn’t conflict with existing trademarks to avoid legal issues later on.</li>
        </ol>

        <p>A good UK domain name will help establish credibility and make it easier for customers to find and connect with your business online.</p>']],
      colours_fonts: ['Colors/Fonts/Style',['<blockquote>
        <p>Choosing the right colors for your new business is crucial, as colors evoke emotions and perceptions that can influence customer behavior. Here&#39;s some advice on how to effectively select colors for your brand:</p>
        </blockquote>

        <p>1. <strong>Understand Color Psychology</strong></p>

        <ul>
        <li>  <strong>Red:</strong> Conveys energy, passion, and excitement. Often used in food and entertainment industries.</li>
        <li>  <strong>Blue:</strong> Represents trust, reliability, and calmness. Common in finance, technology, and healthcare.</li>
        <li>  <strong>Green:</strong> Symbolizes nature, health, and growth. Suitable for eco-friendly brands and health-related businesses.</li>
        <li>  <strong>Yellow:</strong> Evokes optimism and cheerfulness. Can be attention-grabbing but should be used sparingly.</li>
        <li>  <strong>Purple:</strong> Associated with luxury, creativity, and sophistication. Often used by beauty and high-end brands.</li>
        <li>  <strong>Black:</strong> Conveys elegance, power, and sophistication. Common in luxury and fashion industries.</li>
        <li>  <strong>White:</strong> Represents purity and simplicity. Often used in healthcare and minimalistic designs.</li>
        </ul>

        <p>2. <strong>Consider Your Target Audience</strong></p>

        <ul>
        <li>  Think about the demographics of your target audience (age, gender, culture) and how they might perceive different colors. For example, younger audiences might be drawn to vibrant colors, while older audiences may prefer muted tones.</li>
        </ul>

        <p>3. <strong>Analyze Competitors</strong></p>

        <ul>
        <li>  Research your competitors to see what colors they use. This can help you identify common themes in your industry while also allowing you to differentiate your brand.</li>
        </ul>

        <p>4. <strong>Limit Your Color Palette</strong></p>

        <ul>
        <li>  Choose a primary color and one or two complementary colors. A limited palette helps maintain brand consistency and makes your logo and marketing materials more recognizable.</li>
        </ul>

        <p>5. <strong>Test Combinations</strong></p>

        <ul>
        <li>  Use tools like <a href="https://color.adobe.com/">Adobe Color</a> or <a href="https://coolors.co/">Coolors</a> to experiment with different color combinations. Testing how colors look together can help you find a harmonious palette.</li>
        </ul>

        <p>6. <strong>Consider Versatility</strong></p>

        <ul>
        <li>  Make sure the colors you choose work well across different mediums (print, web, merchandise) and in various contexts (light vs. dark backgrounds).</li>
        </ul>

        <p>7. <strong>Get Feedback</strong></p>

        <ul>
        <li>  Once you&#39;ve narrowed down your options, seek feedback from potential customers or stakeholders. Their perceptions can provide valuable insights into how your color choices resonate.</li>
        </ul>

        <p>8. <strong>Align with Your Brand Values</strong></p>

        <ul>
        <li>  Ensure that your color choices reflect your brand&#39;s mission and values. Consistency in messaging helps build trust with your audience.</li>
        </ul>

        <p><strong>Conclusion</strong></p>

        <p>Colors play a significant role in how your brand is perceived. By understanding color psychology, knowing your audience, and testing various combinations, you can create a color palette that enhances your brand identity and attracts customers effectively.</p>']],
      consistency: [
        'Consistency',
        ['<blockquote>
          <p>Consistency in the look and feel of your brand is crucial when creating a new business. It helps establish brand identity, build trust, and enhance recognition across different platforms. Here are some key points to consider for maintaining consistency:</p>
          </blockquote>

          <ol>
          <li><p><strong>Develop a Brand Style Guide:</strong> Create a comprehensive document that outlines your brand&#39;s visual elements, including logo usage, color palette, typography, imagery styles, and any design patterns. This guide serves as a reference for anyone creating marketing materials or communications.</p></li>
          <li><p><strong>Use a Cohesive Color Palette:</strong> Choose a specific set of colors that reflect your brand&#39;s personality and values. Stick to these colors across all branding materials, including your website, social media, packaging, and advertisements.</p></li>
          <li><p><strong>Select Consistent Typography:</strong> Pick a couple of typefaces (one for headings and another for body text) and use them consistently in all communications. Ensure that the fonts you choose align with your brand&#39;s tone---formal, casual, modern, etc.</p></li>
          <li><p><strong>Maintain Logo Integrity:</strong> Ensure your logo is used correctly and consistently. Follow the guidelines in your style guide for spacing, sizing, and color variations. Avoid altering the logo in ways that could dilute your brand identity.</p></li>
          <li><p><strong>Uniform Imagery and Graphics:</strong> Choose a specific style for photographs, illustrations, and icons. Whether you prefer a minimalist look, bold graphics, or warm and inviting imagery, maintaining a consistent style helps reinforce your brand&#39;s identity.</p></li>
          <li><p><strong>Consistent Tone of Voice:</strong> While this relates more to written content, ensure your messaging aligns with your brand&#39;s personality. Whether formal, friendly, or quirky, the tone should remain consistent across all platforms and communications.</p></li>
          <li><p><strong>Regularly Review and Update:</strong> As your business evolves, review your branding elements regularly to ensure they still align with your vision and target audience. Make updates as needed while maintaining the core elements for consistency.</p></li>
          <li><p><strong>Train Your Team:</strong> Ensure everyone involved in your business understands the importance of brand consistency. Provide training on how to use the brand style guide and adhere to established guidelines.</p></li>
          </ol>

          <p>By maintaining consistency in your brand&#39;s look and feel, you create a strong identity that resonates with your audience, fosters loyalty, and sets the foundation for your business&#39;s growth.</p>']],
      workwear: [
        'Work Wear',
        ['<p>When creating a new business, particularly one that involves a physical workforce or customer interactions, choosing the right work wear is crucial for several reasons, including brand identity, employee comfort, and professionalism. Here are some key considerations and advice for selecting and implementing work wear:</p>

          <p>1. <strong>Understand Your Brand Identity</strong></p>

          <ul>
          <li>  <strong>Reflect Brand Values:</strong> Choose work wear that aligns with your brand image and values. For example, a tech company may prefer smart-casual attire, while a construction firm may require durable, safety-compliant clothing.</li>
          <li>  <strong>Consistent Branding:</strong> Incorporate your logo and brand colors into the work wear design to enhance brand recognition.</li>
          </ul>

          <p>2. <strong>Consider the Nature of Work</strong></p>

          <ul>
          <li>  <strong>Functionality:</strong> Assess the tasks your employees will perform. For physically demanding jobs, opt for durable, functional clothing that allows freedom of movement.</li>
          <li>  <strong>Safety Compliance:</strong> Ensure that work wear adheres to relevant safety regulations and standards for your industry, such as high-visibility clothing for outdoor workers or protective gear for construction jobs.</li>
          </ul>

          <p>3. <strong>Prioritize Comfort and Fit</strong></p>

          <ul>
          <li>  <strong>Comfort is Key:</strong> Employees are more productive when they are comfortable. Choose breathable fabrics and ergonomic designs.</li>
          <li>  <strong>Variety in Sizing:</strong> Offer a range of sizes to accommodate all body types, ensuring that every employee can find a comfortable fit.</li>
          </ul>

          <p>4. <strong>Think About Seasonal Needs</strong></p>

          <ul>
          <li>  <strong>Adapt to Climate:</strong> Provide appropriate work wear for different seasons, such as lightweight options for summer and insulated layers for winter.</li>
          <li>  <strong>Layering Options:</strong> Consider offering layering options that employees can adjust according to changing weather conditions.</li>
          </ul>

          <p>5. <strong>Incorporate Customization Options</strong></p>

          <ul>
          <li>  <strong>Personal Touch:</strong> Allow employees to customize their work wear with their names or roles. This can enhance team spirit and professionalism.</li>
          <li>  <strong>Employee Input:</strong> Involve employees in the selection process to ensure the work wear meets their preferences and needs.</li>
          </ul>

          <p>6. <strong>Plan for Maintenance and Durability</strong></p>

          <ul>
          <li>  <strong>Durability:</strong> Invest in high-quality materials that can withstand daily wear and tear, reducing replacement costs over time.</li>
          <li>  <strong>Care Instructions:</strong> Provide clear care instructions to help employees maintain their work wear, ensuring it lasts longer.</li>
          </ul>

          <p>7. <strong>Budget Considerations</strong></p>

          <ul>
          <li>  <strong>Cost vs. Quality:</strong> Balance your budget with the need for quality work wear. Cheaper options may save money upfront but could lead to higher replacement costs in the long run.</li>
          <li>  <strong>Bulk Ordering:</strong> Consider ordering in bulk to reduce costs and ensure uniformity.</li>
          </ul>

          <p>8. <strong>Establish Clear Policies</strong></p>

          <ul>
          <li>  <strong>Dress Code Guidelines:</strong> Develop a clear dress code policy outlining acceptable work wear, grooming standards, and any specific requirements based on the role or environment.</li>
          <li>  <strong>Enforcement:</strong> Ensure that guidelines are communicated effectively and consistently enforced to maintain professionalism.</li>
          </ul>

          <p>9. <strong>Promote Team Unity</strong></p>

          <ul>
          <li>  <strong>Uniforms for Team Spirit:</strong> Consider implementing uniforms to foster a sense of belonging and teamwork among employees.</li>
          <li>  <strong>Recognition:</strong> Use work wear as a means to recognize employees&#39; contributions, such as special uniforms for achievements or milestones.</li>
          </ul>

          <p><strong>Conclusion</strong></p>

          <p>Selecting the right work wear is an essential aspect of creating a professional and cohesive image for your new business. By prioritizing comfort, functionality, and brand identity, you can enhance employee morale, improve productivity, and leave a positive impression on customers.</p>']
      ],
      values: [
        'Values',
        ['<p>Establishing <strong>core values</strong> is essential in the process of creating a new business, as they serve as guiding principles that shape the company&#39;s culture, decision-making, and interactions with customers and employees. Here&#39;s some advice on how to define and implement core values effectively:</p>

          <p>1. <strong>Identify What Matters Most</strong></p>

          <ul>
          <li>  <strong>Reflect on Your Mission:</strong> Consider the mission of your business and what you want to achieve. Core values should align with your overall goals.</li>
          <li>  <strong>Involve Key Stakeholders:</strong> Engage with co-founders, employees, and even customers to gather insights about what they believe the company should stand for.</li>
          </ul>

          <p>2. <strong>Be Authentic</strong></p>

          <ul>
          <li>  <strong>Stay True to Yourself:</strong> Choose values that genuinely reflect your beliefs and the culture you want to cultivate. Avoid adopting popular values just because they are trendy; authenticity resonates more with people.</li>
          </ul>

          <p>3. <strong>Keep It Concise</strong></p>

          <ul>
          <li>  <strong>Limit the Number of Values:</strong> Aim for 3 to 7 core values. This makes them easier to remember and implement. Each value should have a clear and concise definition.</li>
          </ul>

          <p>4. <strong>Make Them Actionable</strong></p>

          <ul>
          <li>  <strong>Define What Each Value Means:</strong> For each core value, provide examples of how they can be applied in daily operations and decision-making. This clarity will help employees understand how to embody these values.</li>
          </ul>

          <p>5. <strong>Communicate and Embed</strong></p>

          <ul>
          <li>  <strong>Share with Your Team:</strong> Clearly communicate your core values to all employees, and integrate them into the onboarding process for new hires.</li>
          <li>  <strong>Lead by Example:</strong> As a leader, demonstrate these values in your actions and decisions. This sets the tone for the rest of the organization.</li>
          </ul>

          <p>6. <strong>Evaluate and Adapt</strong></p>

          <ul>
          <li>  <strong>Regularly Review Values:</strong> As your business grows and evolves, periodically reassess your core values to ensure they remain relevant and reflect the current culture of your organization.</li>
          <li>  <strong>Gather Feedback:</strong> Encourage employees to provide feedback on how well the company is living up to its core values, and be open to making adjustments if necessary.</li>
          </ul>

          <p>7. <strong>Celebrate Your Values</strong></p>

          <ul>
          <li>  <strong>Recognize Employees:</strong> Acknowledge and reward employees who exemplify your core values. This reinforces their importance and encourages others to follow suit.</li>
          </ul>

          <p><strong>Conclusion</strong></p>

          <p>Core values are not just words; they are the foundation of your business&#39;s identity. By thoughtfully defining, communicating, and embodying your core values, you create a strong culture that can guide your business toward long-term success.</p>']
      ],
      mision_statement: [
        'Mission Statement',
        ['<p>Creating a strong mission statement is an essential step in the process of establishing a new business. It serves as a guiding light for your organization, helping to define its purpose and direction. Here are some key pieces of advice for crafting an effective mission statement:</p>

          <ol>
          <li><p><strong>Define Your Purpose:</strong> Clearly articulate the primary purpose of your business. Ask yourself what problem your business solves and why it exists beyond just making a profit.</p></li>
          <li><p><strong>Keep It Concise:</strong> A mission statement should be brief and to the point, ideally one to two sentences long. It should be easy to remember and communicate.</p></li>
          <li><p><strong>Incorporate Core Values:</strong> Reflect the core values of your business in the mission statement. This helps convey what your business stands for and what principles guide your decisions.</p></li>
          <li><p><strong>Focus on the Audience:</strong> Consider who your mission statement is intended for. It should resonate with both your internal team and your external audience, including customers and stakeholders.</p></li>
          <li><p><strong>Make It Inspirational:</strong> A good mission statement should motivate and inspire both employees and customers. Use language that evokes passion and commitment.</p></li>
          <li><p><strong>Be Specific but Flexible:</strong> While it&#39;s important to be specific about what your business does, avoid being so narrow that it limits future growth or evolution. A flexible statement allows for adaptation as your business evolves.</p></li>
          <li><p><strong>Review and Revise:</strong> Your mission statement may evolve over time as your business grows. Regularly review it to ensure it still aligns with your goals and values.</p></li>
          </ol>

          <p><strong>Example Structure:</strong></p>

          <ul>
          <li>  <strong>What do we do?</strong> (What products/services do we provide?)</li>
          <li>  <strong>Who do we serve?</strong> (Who are our customers?)</li>
          <li>  <strong>How do we do it?</strong> (What unique approach or values do we bring?)</li>
          </ul>

          <p><strong>Example Mission Statements:</strong></p>

          <ul>
          <li>  <strong>&quot;To provide eco-friendly cleaning solutions that make homes healthier while protecting the planet.&quot;</strong></li>
          <li>  <strong>&quot;To empower small businesses through innovative technology solutions that streamline operations and enhance customer engagement.&quot;</strong></li>
          </ul>

          <p>By following these guidelines, you can create a mission statement that effectively communicates your business&#39;s purpose and sets the stage for its future success.</p>
          '
        ],
      ],
      title: [
        'Business Idea Title/Name',
        ['<p>The title you choose for your business idea is important because it acts as a unique reference point for all your analyses and final business plan. It will be used to connect your PESTEL analysis, SWOT analysis, and other insights. Here’s how to choose a good title:</p>

          <ol>
            <li><strong>Be Descriptive:</strong> Choose a title that clearly reflects the nature of your business idea. Avoid vague names.</li>
            <li><strong>Think About Future Use:</strong> This title will be used later when compiling your full business plan, so pick something meaningful.</li>
            <li><strong>Keep It Concise:</strong> The title should be short yet descriptive enough to help you recognize your idea at a glance.</li>
            <li><strong>Avoid Generic Titles:</strong> Titles like “My Startup” or “New Business” don’t help in distinguishing your ideas.</li>
          </ol>

          <p><strong>Examples of Good Titles:</strong></p>

          <ul>
            <li>Eco-Friendly Packaging Solutions</li>
            <li>AI-Powered HR Software</li>
            <li>London-Based Mobile Coffee Truck</li>
          </ul>

          <p>By choosing a strong and relevant title, you ensure a smooth process for connecting your business idea with AI-driven analyses and the final business plan.</p>'
        ]
      ],
      description: [
        'Business Description',
        ['<p>Providing a clear and detailed business description is essential. This helps you define your business model, set expectations, and allows AI to generate better recommendations. Here’s why it matters:</p>

          <ol>
            <li><strong>Clarifies Your Vision:</strong> Writing a detailed description forces you to think through your business model, products, and services.</li>
            <li><strong>Improves AI Recommendations:</strong> The more details you provide about your business goals, target audience, and industry, the better AI-generated insights will be.</li>
            <li><strong>Helps in Business Planning:</strong> Investors, partners, and financial institutions often review business descriptions to understand feasibility and potential growth.</li>
            <li><strong>Focuses Market Research:</strong> A well-defined description ensures that market research aligns with your specific industry and niche.</li>
          </ol>

          <p><strong>What to Include in Your Business Description?</strong></p>

          <ul>
            <li>What products or services do you offer?</li>
            <li>Who is your target audience?</li>
            <li>What problems does your business solve?</li>
            <li>What makes your business unique?</li>
          </ul>

          <p>For best results, provide as much information as possible when filling in this section. The more details you give, the better AI-driven insights and market analysis you will receive.</p>']
      ],
      country: [
        'Business Location',
        ['<p>Selecting the right country for your business is a key decision that affects everything from legal regulations to market opportunities. Here’s why choosing the correct country is crucial:</p>

          <ol>
            <li><strong>Legal & Tax Regulations:</strong> Business laws, tax structures, and registration requirements vary by country. Make sure to research local regulations before proceeding.</li>
            <li><strong>PESTEL & SWOT Analysis:</strong> The business environment is different for each country. AI will generate PESTEL (Political, Economic, Social, Technological, Environmental, and Legal) and SWOT (Strengths, Weaknesses, Opportunities, Threats) analyses based on your selected location.</li>
            <li><strong>Market Potential:</strong> Some countries may have a higher demand for your product or service, while others may be saturated or highly competitive.</li>
            <li><strong>Funding & Support:</strong> Many governments offer grants, incentives, and startup programs. The country you choose could impact access to financial resources.</li>
          </ol>

          <p><strong>Examples of Country-Specific Differences:</strong></p>

          <ul>
            <li><strong>UK:</strong> Strong regulatory framework, access to government funding, and an established financial market.</li>
            <li><strong>USA:</strong> Large market potential, strong startup ecosystem, but state-specific tax laws.</li>
            <li><strong>Canada:</strong> Business-friendly policies, immigration support for entrepreneurs, and access to North American markets.</li>
          </ul>

          <p>Make sure to select the correct country when setting up your business, as it will directly impact financial, operational, and strategic decisions.</p>']
      ],
      todo: [
        'TODO',
        ['<h1>TODO</h1>']
      ],
      p_strengths: [
        'Personal SWOT Assessment - Strengths',
        ['<p>Identifying your strengths is a crucial part of self-assessment. Understanding what you do well can help you maximize your potential and make informed business decisions. Here’s why assessing your strengths is important:</p>

          <ol>
            <li><strong>Self-Awareness:</strong> Knowing your strengths allows you to leverage them effectively in business and personal development.</li>
            <li><strong>Competitive Advantage:</strong> Your unique skills, expertise, and personal attributes set you apart from others in the market.</li>
            <li><strong>Confidence & Motivation:</strong> Recognizing what you excel at can boost self-confidence and keep you motivated to achieve your goals.</li>
            <li><strong>Strategic Decision-Making:</strong> Aligning your strengths with business opportunities increases the likelihood of success and minimizes risks.</li>
          </ol>

          <p><strong>Examples of Personal Strengths:</strong></p>

          <ul>
            <li><strong>Leadership:</strong> Ability to inspire and guide a team toward a common goal.</li>
            <li><strong>Problem-Solving:</strong> Strong analytical thinking and the ability to find solutions to challenges.</li>
            <li><strong>Adaptability:</strong> Quickly adjusting to new situations, industries, or technologies.</li>
            <li><strong>Communication Skills:</strong> Effectively conveying ideas, building relationships, and persuading stakeholders.</li>
            <li><strong>Resilience:</strong> Staying determined and focused even in the face of setbacks.</li>
          </ul>

          <p>Understanding and utilizing your strengths will help you build a successful business and become a more effective entrepreneur. Be honest in your self-assessment and continuously develop your strong points.</p>']
      ],
      p_weaknesses: [
        'Personal SWOT Assessment - Weaknesses',
        ["<p>Identifying your weaknesses is a crucial step in self-improvement and business success. Being aware of your limitations allows you to develop strategies to overcome them and seek support where needed.</p>

          <ol>
            <li><strong>Skill Gaps:</strong> You might lack certain technical, financial, or leadership skills required for entrepreneurship. Recognizing these gaps helps in planning for training or finding co-founders with complementary strengths.</li>
            <li><strong>Limited Experience:</strong> If you're new to entrepreneurship or a specific industry, a lack of hands-on experience can be a challenge. Gaining mentorship or starting small can mitigate this risk.</li>
            <li><strong>Risk Aversion:</strong> Some individuals struggle with decision-making under uncertainty, which can slow down progress in a dynamic business environment. Developing confidence and risk assessment skills is key.</li>
            <li><strong>Time Management:</strong> Poor prioritization and productivity habits can lead to missed opportunities. Learning to delegate, automate tasks, and maintain a structured schedule can help.</li>
            <li><strong>Financial Constraints:</strong> Limited personal funds, poor budgeting skills, or lack of access to capital can be significant barriers. Exploring funding options like grants, loans, or partnerships is essential.</li>
          </ol>

          <p><strong>Examples of Personal Weaknesses in Business:</strong></p>

          <ul>
            <li><strong>Confidence Issues:</strong> Hesitation in networking, pitching ideas, or making decisions can slow business growth.</li>
            <li><strong>Lack of Technical Knowledge:</strong> Not knowing how to build a website, use financial tools, or leverage marketing platforms can put you at a disadvantage.</li>
            <li><strong>Struggles with Delegation:</strong> Trying to do everything yourself can lead to burnout and inefficiency.</li>
          </ul>

          <p>Recognizing your weaknesses isn’t about self-criticism; it’s about taking proactive steps to improve and grow as an entrepreneur.</p>"]
      ],
      p_opportunities: [
        'Personal SWOT Assessment - Opportunities',
        ['<p>Opportunities refer to external factors that can support your entrepreneurial journey. These are elements outside of your direct control but can be leveraged to accelerate business success. Identifying and taking advantage of these opportunities can give you a strategic edge.</p>
      
          <ol>
            <li><strong>Market Trends & Emerging Industries:</strong> If your skills or business idea align with growing trends such as AI, sustainability, or digital transformation, you have an opportunity to enter a high-demand market.</li>
            <li><strong>Networking & Mentorship:</strong> Having access to experienced mentors, business networks, and industry experts can provide valuable insights, partnerships, and funding opportunities.</li>
            <li><strong>Funding & Grants:</strong> Various organizations, governments, and venture capitalists offer funding, grants, and incubator programs to support new entrepreneurs. Research what’s available in your location.</li>
            <li><strong>Technology & Automation:</strong> Advancements in AI, automation, and digital tools make it easier and more affordable to start and scale a business than ever before.</li>
            <li><strong>Flexible Work & Remote Opportunities:</strong> The rise of remote work and global collaboration allows entrepreneurs to tap into international talent, reduce operational costs, and access wider markets.</li>
          </ol>
      
          <p><strong>Examples of External Opportunities for Entrepreneurs:</strong></p>
      
          <ul>
            <li><strong>UK:</strong> Government startup loans, incubators like Tech Nation, and strong fintech and AI sectors.</li>
            <li><strong>USA:</strong> Access to venture capital, startup accelerators (Y Combinator, Techstars), and a culture that supports risk-taking.</li>
            <li><strong>Canada:</strong> Startup visa programs, government-backed grants for innovation, and entrepreneur-friendly immigration policies.</li>
          </ul>
      
          <p>Recognizing and leveraging these external opportunities can help you navigate challenges and build a successful business with a strong foundation.</p>']
      ],
      p_threats: [
        'Threats in Personal SWOT Assessment',
        ['<p>Identifying potential threats in your personal SWOT analysis is crucial for mitigating risks and preparing for challenges that might impact your entrepreneurial journey. Here’s why understanding threats is important:</p>
      
          <ol>
            <li><strong>Market Competition:</strong> Other businesses might already dominate the market. If you lack a strong unique value proposition, you may struggle to gain traction.</li>
            <li><strong>Financial Constraints:</strong> Limited savings, lack of funding, or unstable financial conditions can make it difficult to sustain your business in its early stages.</li>
            <li><strong>Skill Gaps:</strong> If you lack critical skills in business management, marketing, or technology, you may face difficulties in running and scaling your business.</li>
            <li><strong>External Economic & Political Factors:</strong> Recessions, policy changes, or unstable economic conditions can create obstacles for entrepreneurs, making it harder to secure funding or grow a business.</li>
            <li><strong>Work-Life Balance Challenges:</strong> Entrepreneurship demands time and energy. If you have personal responsibilities or struggle with stress management, maintaining productivity and motivation could become difficult.</li>
          </ol>
      
          <p><strong>Examples of Personal Threats:</strong></p>
      
          <ul>
            <li><strong>Lack of Experience:</strong> If you’re new to entrepreneurship, making costly mistakes due to inexperience is a potential risk.</li>
            <li><strong>Limited Professional Network:</strong> Having a small or weak network can slow down your business growth, as connections often lead to partnerships, funding, and opportunities.</li>
            <li><strong>Fear of Failure:</strong> Self-doubt and risk aversion may prevent you from making bold decisions necessary for business success.</li>
            <li><strong>Time Management Issues:</strong> Struggling to prioritize tasks effectively can lead to burnout or missed opportunities.</li>
          </ul>
      
          <p>By recognizing these threats early, you can take steps to minimize their impact, whether by improving skills, seeking mentorship, or strengthening financial planning.</p>']
      ],
      business_model: [
        'Understanding Business Creation Models',
        ['<p>Selecting the right business model is crucial for structuring your entrepreneurial journey. Each model provides a different approach to building and scaling a business.</p>
  
        <h4>1. <strong>9 Stages of Enterprise Creation</strong></h4>
        <p>This structured approach, widely used in the UK startup ecosystem, guides entrepreneurs through:</p>
        <ul>
          <li><strong>Business Owner Characteristics:</strong> Assessing personal skills and readiness.</li>
          <li><strong>Business Idea Definition:</strong> Refining and validating the business idea.</li>
          <li><strong>Market Research:</strong> Understanding market needs, customers, and competitors.</li>
          <li><strong>Competitor Analysis:</strong> Identifying and analyzing competitors.</li>
          <li><strong>Business Model Definition:</strong> Structuring the business around revenue streams.</li>
          <li><strong>Strategy Development:</strong> Planning growth and operational strategies.</li>
          <li><strong>Financial Planning:</strong> Budgeting, investment, and cash flow management.</li>
          <li><strong>Legal & Operations:</strong> Managing legal structures, licenses, and day-to-day operations.</li>
          <li><strong>Business Plan Finalization:</strong> Preparing a business plan for execution and funding.</li>
        </ul>
  
        <h4>2. <strong>Lean Startup (Eric Ries)</strong></h4>
        <p>This model emphasizes rapid experimentation and customer feedback. Ideal for technology startups and innovative businesses.</p>
        <ul>
          <li><strong>Build an MVP:</strong> Develop a Minimum Viable Product (MVP) with essential features.</li>
          <li><strong>Measure & Learn:</strong> Gather feedback and iterate quickly.</li>
          <li><strong>Pivot or Persist:</strong> Make necessary changes based on market response.</li>
        </ul>
  
        <h4>3. <strong>Business Model Canvas (Osterwalder & Pigneur)</strong></h4>
        <p>A visual business planning tool that helps define:</p>
        <ul>
          <li><strong>Key Partners:</strong> Essential collaborators.</li>
          <li><strong>Value Proposition:</strong> The unique value you offer to customers.</li>
          <li><strong>Customer Segments:</strong> Target audience and market segmentation.</li>
          <li><strong>Revenue Streams:</strong> How the business generates income.</li>
        </ul>
  
        <h4>4. <strong>9 Stages of Enterprise Creation (Bozward, 2017)</strong></h4>
        <p>This model focuses on the full entrepreneurial lifecycle:</p>
        <ul>
          <li><strong>Discovery:</strong> Identifying business opportunities.</li>
          <li><strong>Modeling:</strong> Structuring the business.</li>
          <li><strong>Startup:</strong> Initial launch and execution.</li>
          <li><strong>Existence:</strong> Establishing market presence.</li>
          <li><strong>Survival:</strong> Maintaining cash flow and financial stability.</li>
          <li><strong>Success:</strong> Expanding and scaling.</li>
          <li><strong>Adaptation:</strong> Adjusting to market changes.</li>
          <li><strong>Independence:</strong> Achieving operational stability.</li>
          <li><strong>Exit:</strong> Planning business succession or selling.</li>
        </ul>
  
        <p><strong>Which Model Should You Choose?</strong> Your choice should align with your industry, business type, and risk tolerance. Understanding these models will help you develop a strategic path to success.</p>']
      ]
    }
    element = element.to_sym

    bootstrap_offcanvas(
      button_text: '', 
      offcanvas_id: element, 
      title: info[element][0], 
      html_content: info[element][1]
    )
  end

  # Helper to create an offcanvas component
  def bootstrap_offcanvas(button_text:, offcanvas_id:, title:, html_content: [], position: "end", width: "w-80")
    # Generate the button to toggle the offcanvas
    button = content_tag(:a,
                        raw('<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Info:"><use xlink:href="#info-fill"/></svg>') + button_text,
                         class: "btn-outline-info btn-sm", 
                         type: "button", 
                         data: { bs_toggle: "offcanvas", bs_target: "##{offcanvas_id}" }, 
                         aria: { controls: offcanvas_id })

    # Generate the offcanvas element
    offcanvas = content_tag(:div, class: "offcanvas offcanvas-#{position} #{width}", 
                            tabindex: "-1", id: offcanvas_id, 
                            aria: { labelledby: "#{offcanvas_id}Label" }) do
      # Offcanvas header
      header = content_tag(:div, class: "offcanvas-header") do
        content_tag(:h5, title, id: "#{offcanvas_id}Label") +
        content_tag(:button, nil, 
                    class: "btn-close text-reset", 
                    type: "button", 
                    data: { bs_dismiss: "offcanvas" }, 
                    aria: { label: "Close" })
      end

      # Offcanvas body
      body = content_tag(:div, class: "offcanvas-body") do
        # Join the HTML array content safely
        html_content.map(&:html_safe).join.html_safe
      end

      header + body
    end

    # Combine and return the button and the offcanvas
    button + offcanvas
  end

  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "UK Business").join(" - ")
      end
    end
  end

  private

  def render_breadcrumbs(items)
    return if items.empty?

    content_tag(:nav, aria: { label: "breadcrumb" }) do
      (content_tag(:ol, class: "breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5") do
        items.each_with_index.map do |item, index|
          if index == items.size - 1
            content_tag(:li, item, class: "breadcrumb-item text-sm text-white active", aria: { current: "page" })
          else
            content_tag(:li, item, class: "breadcrumb-item text-sm text-white")
          end
        end.join.html_safe
      end)+
      content_tag(:h6, controller_name, class: "font-weight-bolder text-capitalize text-white mb-0").html_safe
    end
  end

  def format_text_to_html(text)
    return "" if text.nil? || text.strip.empty?
  
    formatted_text = text
      .gsub(/\*\*(.*?)\*\*/, '<strong>\1</strong>') # Convert **bold** to <strong>
      .gsub(/\*(.*?)\*/, '<h6 class="d-inline">\1</h6>') # Convert *italic* to inline <h6>
      .gsub(/^(\d+)\.\s+/, '<li class="list-group-item">\1. ') # Convert numbered list items into list-group-item
      .gsub(/\n- (.*)/, '<p>\1</p>') # Convert bullet points into paragraph inside list items
      .gsub(/(<li class="list-group-item">.*?<\/p>)/m, '<ul class="list-group">\1</ul>') # Wrap list items inside <ul>
      .gsub(/\n{2,}/, "</p><p>") # Convert double newlines to paragraphs
      .gsub(/\n/, '<br>') # Convert single newlines to line breaks
  
      # match = formatted_text.match(/^(\d+)\.\s([\w\s]+):\s(.*)$/)
      # puts match
      # formatted_text = "<li class='list-group-item'>#{match[1]}. <h6 class='d-inline'>#{match[2]}:</h6> #{match[3]}</li>"
    "<div>#{formatted_text}</div>".html_safe
  end
end