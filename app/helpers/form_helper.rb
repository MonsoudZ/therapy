module FormHelper
  def form_field_classes
    "w-full rounded-lg border border-gray-300 px-4 py-3 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 focus:outline-none transition-colors"
  end

  def error_message_for(field, errors)
    if errors[field].any?
      content_tag(:p, errors[field].first, class: "mt-1 text-sm text-red-600")
    end
  end

  def us_states_options
    [
      %w[Alabama AL], %w[Alaska AK], %w[Arizona AZ], %w[Arkansas AR], %w[California CA],
      %w[Colorado CO], %w[Connecticut CT], %w[Delaware DE], %w[Florida FL], [ "Georgia", "GA" ],
      %w[Hawaii HI], [ "Idaho", "ID" ], [ "Illinois", "IL" ], [ "Indiana", "IN" ], [ "Iowa", "IA" ],
      [ "Kansas", "KS" ], [ "Kentucky", "KY" ], [ "Louisiana", "LA" ], [ "Maine", "ME" ], [ "Maryland", "MD" ],
      [ "Massachusetts", "MA" ], [ "Michigan", "MI" ], [ "Minnesota", "MN" ], [ "Mississippi", "MS" ], [ "Missouri", "MO" ],
      [ "Montana", "MT" ], [ "Nebraska", "NE" ], [ "Nevada", "NV" ], [ "New Hampshire", "NH" ], [ "New Jersey", "NJ" ],
      [ "New Mexico", "NM" ], [ "New York", "NY" ], [ "North Carolina", "NC" ], [ "North Dakota", "ND" ], [ "Ohio", "OH" ],
      [ "Oklahoma", "OK" ], [ "Oregon", "OR" ], [ "Pennsylvania", "PA" ], [ "Rhode Island", "RI" ], [ "South Carolina", "SC" ],
      [ "South Dakota", "SD" ], [ "Tennessee", "TN" ], [ "Texas", "TX" ], [ "Utah", "UT" ], [ "Vermont", "VT" ],
      [ "Virginia", "VA" ], [ "Washington", "WA" ], [ "West Virginia", "WV" ], [ "Wisconsin", "WI" ], [ "Wyoming", "WY" ],
      [ "Washington DC", "DC" ]
    ]
  end
end
