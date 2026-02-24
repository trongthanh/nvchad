-- Vietnamese Unicode to Latin character mapping
-- stylua: ignore
local vietnamese_map = {
  -- Lowercase vowels with diacritics
  ["à"] = "a",  ["á"] = "a",  ["ả"] = "a",  ["ã"] = "a",  ["ạ"] = "a",  ["ă"] = "a",  ["ằ"] = "a",  ["ắ"] = "a",  ["ẳ"] = "a",  ["ẵ"] = "a",  ["ặ"] = "a",  ["â"] = "a",  ["ầ"] = "a",  ["ấ"] = "a",  ["ẩ"] = "a",  ["ẫ"] = "a",  ["ậ"] = "a",  ["è"] = "e",  ["é"] = "e",  ["ẻ"] = "e",  ["ẽ"] = "e",  ["ẹ"] = "e",  ["ê"] = "e",  ["ề"] = "e",  ["ế"] = "e",  ["ể"] = "e",  ["ễ"] = "e",  ["ệ"] = "e",  ["ì"] = "i",  ["í"] = "i",  ["ỉ"] = "i",  ["ĩ"] = "i",  ["ị"] = "i",  ["ò"] = "o",  ["ó"] = "o",  ["ỏ"] = "o",  ["õ"] = "o",  ["ọ"] = "o",  ["ô"] = "o",  ["ồ"] = "o",  ["ố"] = "o",  ["ổ"] = "o",  ["ỗ"] = "o",  ["ộ"] = "o",  ["ơ"] = "o",  ["ờ"] = "o",  ["ớ"] = "o",  ["ở"] = "o",  ["ỡ"] = "o",  ["ợ"] = "o",  ["ù"] = "u",  ["ú"] = "u",  ["ủ"] = "u",  ["ũ"] = "u",  ["ụ"] = "u",  ["ư"] = "u",  ["ừ"] = "u",  ["ứ"] = "u",  ["ử"] = "u",  ["ữ"] = "u",  ["ự"] = "u",  ["ỳ"] = "y",  ["ý"] = "y",  ["ỷ"] = "y",  ["ỹ"] = "y",  ["ỵ"] = "y",  ["đ"] = "d",
  -- Uppercase vowels with diacritics
  ["À"] = "A",  ["Á"] = "A",  ["Ả"] = "A",  ["Ã"] = "A",  ["Ạ"] = "A",  ["Ă"] = "A",  ["Ằ"] = "A",  ["Ắ"] = "A",  ["Ẳ"] = "A",  ["Ẵ"] = "A",  ["Ặ"] = "A",  ["Â"] = "A",  ["Ầ"] = "A",  ["Ấ"] = "A",  ["Ẩ"] = "A",  ["Ẫ"] = "A",  ["Ậ"] = "A",  ["È"] = "E",  ["É"] = "E",  ["Ẻ"] = "E",  ["Ẽ"] = "E",  ["Ẹ"] = "E",  ["Ê"] = "E",  ["Ề"] = "E",  ["Ế"] = "E",  ["Ể"] = "E",  ["Ễ"] = "E",  ["Ệ"] = "E",  ["Ì"] = "I",  ["Í"] = "I",  ["Ỉ"] = "I",  ["Ĩ"] = "I",  ["Ị"] = "I",  ["Ò"] = "O",  ["Ó"] = "O",  ["Ỏ"] = "O",  ["Õ"] = "O",  ["Ọ"] = "O",  ["Ô"] = "O",  ["Ồ"] = "O",  ["Ố"] = "O",  ["Ổ"] = "O",  ["Ỗ"] = "O",  ["Ộ"] = "O",  ["Ơ"] = "O",  ["Ờ"] = "O",  ["Ớ"] = "O",  ["Ở"] = "O",  ["Ỡ"] = "O",  ["Ợ"] = "O",  ["Ù"] = "U",  ["Ú"] = "U",  ["Ủ"] = "U",  ["Ũ"] = "U",  ["Ụ"] = "U",  ["Ư"] = "U",  ["Ừ"] = "U",  ["Ứ"] = "U",  ["Ử"] = "U",  ["Ữ"] = "U",  ["Ự"] = "U",  ["Ỳ"] = "Y",  ["Ý"] = "Y",  ["Ỷ"] = "Y",  ["Ỹ"] = "Y",  ["Ỵ"] = "Y",  ["Đ"] = "D",
}

-- Function to convert Vietnamese characters to Latin
local function remove_vietnamese_diacritics(text)
  local result = ""

  -- Iterate through each UTF-8 character
  for char in text:gmatch "([%z\1-\127\194-\244][\128-\191]*)" do
    -- Check if character exists in our mapping
    if vietnamese_map[char] then
      result = result .. vietnamese_map[char]
    else
      result = result .. char
    end
  end

  return result
end

--- @module 'obsidian'
--- @type obsidian.config
return {
  legacy_commands = false,
  workspaces = {
    {
      name = "wiki",
      path = "~/Sync/wiki",
    },
  },
  attachments = {
    -- keep images in a dedicated folder
    folder = "/images",
  },
  notes_subdir = "notes",
  templates = {
    enabled = true,
    folder = ".templates",
    substitutions = {
      ["date:ddd MMMM D, YYYY"] = function()
        return os.date "%a %B %-d, %Y"
      end,
    },
  },
  daily_notes = {
    -- Optional, if you want to enable daily notes
    enabled = true,
    -- Optional, if you keep daily notes in a separate directory.
    folder = "journal",
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = "%Y/%m/%Y-%m-%d",
    -- Optional, if you want to change the date format of the default alias of daily notes.
    alias_format = "%a %B %-d, %Y",
    -- Optional, default tags to add to each new daily note created.
    default_tags = { "daily-notes" },
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = "daily-note.md",
    -- Optional, if you want `Obsidian yesterday` to return the last work day or `Obsidian tomorrow` to return the next work day.
    workdays_only = true,
  },
  preferred_link_style = "markdown",

  -- Optional, customize how note IDs are generated given an optional title.
  ---@param title string|?
  ---@return string
  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp (yymmdd) and a suffix.
    -- In this case a note with the title 'My new note' will be given an ID that looks
    -- like '250807-my-new-note', and therefore the file name '250807-my-new-note.md'.
    -- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
    local suffix = ""
    if title ~= nil then
      title = remove_vietnamese_diacritics(title) -- Remove Vietnamese diacritics from the title.
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return os.date "%y%m%d" .. "-" .. suffix
  end,
  checkbox = {
    order = { " ", "/", "x", "-" },
  },
  frontmatter = {
    enabled = true,
  },
  ui = {
    enable = false,
    bullets = { char = "●", hl_group = "ObsidianBullet" },
  },
}
