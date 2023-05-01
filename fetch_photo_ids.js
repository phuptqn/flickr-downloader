const list = document.querySelectorAll('.photo-list-photo-view > .photo-list-photo-container > img');
let ids = 'photo_ids=(';
for (let index = 0; index < list.length; index++) {
  const element = list[index];
  let id = element.src.split('/');
  id = id.pop().split('_')[0];
  ids += `"${id}" `;
}
ids += `)`;