
userProfile.onchange = (e) => {
    const [file] = userProfile.files;
    if (file) {
        profilePreview.src = URL.createObjectURL(file)
    }
}