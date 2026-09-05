const fs = require('fs');

function loadTeam(path) {
  const data = fs.readFileSync(path, 'utf8');
  return JSON.parse(data);
}

function summarize(team) {
  const memberCount = team.length;
  const uniqueRoles = new Set(team.map(member => member.role));

  return {
    memberCount,
    roleCount: uniqueRoles.size,
    roles: Array.from(uniqueRoles)
  };
}

const team = loadTeam('./team.json');
const summary = summarize(team);

console.log(`${summary.memberCount} members, ${summary.roleCount} roles represented`);
summary.roles.forEach(role => console.log(`- ${role}`));