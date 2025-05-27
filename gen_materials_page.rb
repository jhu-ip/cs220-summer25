#! /usr/bin/env ruby

# Generate Course Materials web page (material.md) from material.csv,
# which contains information about all course materials for each day
# of the course.

# Apologies for how complicated this script is. The intent is that
# material.csv is easy to edit and amenable to version control,
# and this script takes care of turning the CSV into HTML (which would
# be much harder to edit.) Much of the complexity is implementing each week
# as a collapsible section.

require 'csv'
require 'date'

# This should be set to the calendar year when the course is being offered
CURRENT_YEAR = '2025'

# If any days should not be numbered, specify them here.
# This is a useful hack if an "extra" work/non-course-content day
# gets inserted into the schedule, and you don't feel like
# renumbering all of the subsequent material (slides, exercises,
# recap questions, etc.) Keys should be a pair [week_number, day_number],
# the mapped value should just be something that evaluates as true.
NON_NUMBERED_DAYS = {
  # Summer 2022: June 20th and July 4th are both holidays with no classes
  #[3, 1] => true,
  #[5, 1] => true,
}

FRONT_STUFF = <<'EOF1'
---
layout: default
title: "Course Material"
category: "material"
---

<!--
IMPORTANT: please don't edit material.md directly.
Instead, edit material.csv, adding a new row for each item you
want to add, and then regenerate materials.md by running
the command

  ./gen_materials_page.rb > material.md

Then add, commit, and push both material.csv and material.md.
-->

You can click on the header for a specific week to expand or collapse
the materials for that week. Recorded lectures can be found in Canvas in the Panopto tab for our class.

EOF1

# Keys for the various kinds of course materials.
KNOWN_KEYS = {
  'Video' => 1,
  'Slides' => 1,
  'Recap' => 1,
  'Exercise' => 1,
  'Resource' => 1,
  'LectureSlides' => 1,
  'Recording' => 1,
  'Ignore' => 1,
}

# Collected information about a particular day of the course.
class DayInfo
  attr_reader :date
  attr_accessor :global_day_number

  def initialize
    @info = {}
    @date = nil
  end

  def add_item(type, link_text, url)
    #raise "Unknown item type #{type}" if !KNOWN_KEYS.has_key?(type)

    if !@info.has_key?(type)
      @info[type] = []
    end

    @info[type].push([link_text, url])
  end

  def set_date(date)
    @date = date
  end

  def get_items(type)
    return [] if !@info.has_key?(type)
    return @info[type]
  end
end

# Collection of DayInfo objects for a particular week of the course.
class Week
  attr_reader :week_num

  def initialize(week_num)
    @week_num = week_num
    # map of day number to DayInfo
    @days = {}
  end

  def [](key)
    return @days[key]
  end

  def []=(key, value)
    @days[key] = value
  end

  def keys
    return @days.keys
  end

  def has_key?(key)
    return @days.has_key?(key)
  end

  def day_numbers
    return keys.sort
  end

  def date_of(pos)
    raise "No days yet!" if @days.empty?
    d = self.day_numbers
    return @days[d[pos]].date
  end

  def first_date
    return date_of(0)
  end

  def first_date_as_date
    # Convert, e.g., "6-Jun" to "6-Jun-2022"
    return Date.parse(self.first_date + '-' + CURRENT_YEAR.to_s)
  end

  def last_date
    return date_of(-1)
  end

  def _to_sunday(d)
    d = Date.new(d.year, d.month, d.day)
    if d.cwday != 7
      d = d - d.cwday
    end
   return d
  end

  # return true if this week is not in the future compared to the week number
  # of the specified current date
  def not_in_future?(current_date)
    return _to_sunday(self.first_date_as_date) <= _to_sunday(current_date)
  end

  # Assign global day numbers to each DayInfo, starting from the given one.
  # Returns what should be the next global day number.
  def assign_global_day_numbers(start)
    n = start

    day_numbers.each do |day_number|
      day_info = @days[day_number]

      if !NON_NUMBERED_DAYS.has_key?([@week_num, day_number])
        day_info.global_day_number = n
        n += 1
      end
    end

    return n
  end
end

def format_link(link_text, url)
  if url == '#'
    # If the URL is just '#', then this is not actually a link.
    # We use this for things like indicating that there is no class.
    return link_text
  elsif url.start_with?('http:') || url.start_with?('https:')
    return "<a class='external' target='_blank' href='#{url}'>#{link_text}</a>"
  else
    #return "[#{link_text}](#{url})"
    return "<a href='#{url}'>#{link_text}</a>"
  end
end

# Map of week numbers to Week objects
weeks = {}

input_filename = ARGV.length == 0 ? 'material.csv' : ARGV[0]

CSV.foreach(input_filename) do |row|
  if row.length == 6 && row[0] != 'Week'
    week_num = row[0].to_i
    day = row[1].to_i
    date = row[2]
    type = row[3]
    link_text = row[4]
    url = row[5]

    if !weeks.has_key?(week_num)
      weeks[week_num] = Week.new(week_num)
    end

    week_info = weeks[week_num]

    if !week_info.has_key?(day)
      week_info[day] = DayInfo.new
      week_info[day].set_date(date)
    end

    day_info = week_info[day]
    day_info.add_item(type, link_text, url)
  end
end

# Based on current day, figure out what the active week should be.
# The rule is that the active week is the latest one that's not in the future.
# (We may want to revisit this policy as we update the course content.)
# As a special case, if no weeks are not in the future (i.e., the current
# date is before the first week of classes), then the first week is active.
current_date = DateTime.now
active_week = nil
weeks.keys.sort.each do |week_num|
  week = weeks[week_num]
  if active_week.nil? || week.not_in_future?(current_date)
    active_week = week
  end
end

# Go through all of the Weeks and assign a global day number
# to each DayInfo
gdn = 1
weeks.keys.sort.each do |week_num|
  week = weeks[week_num]
  gdn = week.assign_global_day_numbers(gdn)
end

# Generate beginning of the Markdown file (with the YAML front matter, etc.)
print FRONT_STUFF

# Generate a collapsible section for each Week.
weeks.keys.sort.each do |week_num|
  week = weeks[week_num]

  days = week.keys.sort

  print <<"EOF2"
<button type="button" id="week_#{week_num}_toggle" class="week_control_button">Week #{week_num} (#{week.first_date} to #{week.last_date})</button>
<div id="week_#{week_num}" class="collapsible">
EOF2

  # print table header
  print <<"EOF3"
<table>
  <thead>
    <tr>
      <th></th>
EOF3
  days.each do |day_num|
    day_info = week[day_num]

    formatted_day = day_info.global_day_number.nil? ? '—' : "Day #{day_info.global_day_number}"

    puts "      <th>#{formatted_day} (#{day_info.date})</th>"
  end
  #puts ''
  print <<"EOF4"
    </tr>
  </thead>
  <tbody>
EOF4

  [
    ['Video', 'Videos'],
    ['Slides', 'Slides'],
    ['Recap', 'Recap<br>Questions'],
    ['Exercise', 'Exercise'],
    ['Resource', 'Additional<br>Resources'],
    ['LectureSlides', 'Lecture<br>Slides'],
    ['Recording', 'Recorded<br>Sessions']
  ].each do |pair|
    type = pair[0]
    row_name = pair[1]

    puts "    <tr>"

    puts "      <td>#{row_name}</td>"

    week.keys.sort.each do |day_num|
      day_info = week[day_num]

      items = day_info.get_items(type)

      print "      <td>"

      first = true
      items.each do |item|
        if first
          first = false
        else
          print "<br>"
        end

        link_text = item[0]
        url = item[1]

        print format_link(link_text, url)
      end

    puts "</td>"
    end

    puts "    </tr>"
  end

  puts "  </tbody>"
  puts "</table>"

  puts "</div>" # end of week content div
end

# Generate JavaScript code to handle the expanding and contracting
# of sections.
print <<"EOF9"
<script type="text/javascript">
  // Create and register a click handler for button clicks to expand/contract
  // specified content div
  function registerClickHandler(content, is_active) {
    //console.log("Registering click handler for " + content.id);

    content.style.display = is_active ? "block" : "none";

    var button_id = content.id + "_toggle";
    //console.log("button_id=" + button_id);

    var button = document.getElementById(button_id);

    button.addEventListener("click", function() {
      button.classList.toggle('active');
      //console.log("content.style.display="+content.style.display);
      if (content.style.display == 'block') {
        content.style.display = 'none';
      } else {
        content.style.display = 'block';
      }
    });

    if (is_active) {
      button.classList.add('active');
    }
  }

  document.addEventListener('DOMContentLoaded', function() {
    var active_week_id = 'week_#{active_week.week_num}';

    var content_divs = document.getElementsByClassName("collapsible");
    for (i = 0; i < content_divs.length; i++) {
      var content = content_divs[i];

      var is_active = (content.id == active_week_id);
      registerClickHandler(content, is_active);
    }
  });
</script>
EOF9
