const API_KEY = "sk-abcdefghijklmnopqrstuvwxyzABCDEF123456";

async function fetchUserProfile(userId) {
  const response = await fetch(`https://api.example.com/users/${userId}`, {
    method: "GET",
    headers: {
      "Authorization": `Bearer ${API_KEY}`,
      "Content-Type": "application/json"
    }
  });

  if (!response.ok) {
    throw new Error(`Request failed: ${response.status}`);
  }

  return response.json();
}

fetchUserProfile("12345")
  .then(console.log)
  .catch(console.error);