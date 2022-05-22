utils = utils or {}

function utils:deleteDir(dir)
    for file in lfs.dir(dir) do
        local file_path = dir .. '/' .. file
        if file ~= "." and file ~= ".." then
            if lfs.attributes(file_path, 'mode') == 'file' then
                os.remove(file_path)
            elseif lfs.attributes(file_path, 'mode') == 'directory' then
                self:deleteDir(file_path)
            end
        end
    end
    lfs.rmdir(dir)
end

function utils:trim(s)
    return s:gsub("^%s+", ""):gsub("%s+$", "")
end

function utils:inArray(val, tab)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function utils:truncate(str, limit)
    local len = string.len(str)
    if len > limit then
        return string.sub(str, 1, limit).."..."
    end
    return str
end

function utils:objectLength(obj)
  local count = 0
  for _ in pairs(obj) do count = count + 1 end
  return count
end

function utils:ucfirst(str)
    return (str:gsub("^%l", string.upper))
end

function utils:split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

-- split z `,` `i`
function utils:splitcommai(str)
    if str then
      local s = {}
      if string.find(str, ", ") then
        s = self:split(str, ", ")
      else
        s = {}
        table.insert(s, str)
      end
      local last = nil
      if s and string.find(s[#s], " i ") then
          last = self:split(s[#s], " i ")
          table.remove(s)
          table.insert(s, last[1])
          table.insert(s, last[2])
      end
      return s
    end
end

function utils:arrayKeys(tab)
    local keyset={}
    local n=0
    for k,v in pairs(tab) do
        n=n+1
        keyset[n]=k
    end
    return keyset
end

function utils:arrayDiff(a, b)
    local aa = {}
    for k,v in pairs(a) do aa[v]=true end
    for k,v in pairs(b) do aa[v]=nil end
    local ret = {}
    local n = 0
    for k,v in pairs(a) do
        if aa[v] then n=n+1 ret[n]=v end
    end
    return ret
end

function utils:ltrim(str, characters_to_remove)
    local chars_to_be_removed
    if nil == characters_to_remove then
        chars_to_be_removed = " \n\t"
    else
        chars_to_be_removed = characters_to_remove
    end
    local characters = {}
    for i = 1, #chars_to_be_removed do
        local ch = string.sub(chars_to_be_removed, i, i)
        characters[string.byte(ch)] = true
    end
    local result = ""
    local done = false
    for i = 1,#str do
        local ch = string.sub(str, i, i)
        if characters[string.byte(ch)] and not done then
        else
            done = true
            result = result .. ch
        end
    end
    return result
end

function utils:rtrim(str, characters_to_remove)
    local reversed_string = string.reverse(str)
    local trimmed_reversed_string = self:ltrim(reversed_string, characters_to_remove)
    local result = string.reverse(trimmed_reversed_string)
    return result
end

-- polaczenia tabeli bez getN
function utils:concat(arr, glue)
    local concat = ""
    if type(arr) == "table" then
        for k, v in pairs(arr) do
            concat = concat .. v .. glue
        end
        return utils:rtrim(concat, glue)
    else
        return arr
    end
end

function utils:dump(var)
  echo("\n")
  if type(var) == "table" then
    for idx, val in pairs(var) do
  		echo(idx..": "..val.."\n")
  	end
  else
    echo(var.."\n")
  end
end
