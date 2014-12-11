debug('Starting')
local rate = alias['rate']
local waitforit = alias['waitforit']

local sleeper = 300

while true do
    debug('sleeping')
    local ts = rate.wait(sleeper)
    debug('awake!')
    sleeper = rate.value
    waitforit.value = ts
end
