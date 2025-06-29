async function saveImage(imageUrl) {
                try {
                    // 1️⃣ Người dùng chọn vị trí lưu ảnh
                    const fileHandle = await window.showSaveFilePicker({
                        suggestedName: "image.jpg", // Tên file gợi ý
                        types: [{description: "Image Files", accept: {"image/jpeg": [".jpg"]}}]
                    });

                    // 2️⃣ Tải ảnh từ URL
                    const response = await fetch(imageUrl);
                    const blob = await response.blob();

                    // 3️⃣ Lưu ảnh vào file đã chọn
                    const writable = await fileHandle.createWritable();
                    await writable.write(blob);
                    await writable.close();

                    alert("Tải ảnh thành công!");
                } catch (error) {
                    alert("Tải ảnh thất bại!");
                }
            }