document.addEventListener('DOMContentLoaded', () => {
    // Fade-in animation for glass containers
    const glassContainers = document.querySelectorAll('.glass-container');
    glassContainers.forEach((container, index) => {
        container.style.opacity = '0';
        container.style.transform = 'translateY(15px)';
        container.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        
        setTimeout(() => {
            container.style.opacity = '1';
            container.style.transform = 'translateY(0)';
        }, 100 * index);
    });

    // Confirmation for destructive tasks
    const deleteButtons = document.querySelectorAll('.btn-delete-confirm');
    deleteButtons.forEach(button => {
        button.addEventListener('click', (e) => {
            const confirmMsg = button.getAttribute('data-confirm') || 'Apakah Anda yakin ingin menghapus data ini?';
            if (!confirm(confirmMsg)) {
                e.preventDefault();
            }
        });
    });
});
