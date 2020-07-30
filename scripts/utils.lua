utils = utils or {}

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

function utils:split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function utils:split2(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
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
