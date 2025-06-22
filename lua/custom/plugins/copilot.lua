-- Set env variable:
-- GITHUB_COPILOT_TOKEN=***
-- To get the token, run :Copilot auth then :Copilot auth info
--
-- Supermaven is better?
-- return {}
return {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      event = 'InsertEnter',
      config = true,
}
